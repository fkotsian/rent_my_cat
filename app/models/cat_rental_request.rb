class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: [ "PENDING", "APPROVED", "DENIED"]  }

  validate :overlapping_approved_requests

  belongs_to :cat,
    class_name: "Cat",
    foreign_key: :cat_id,
    primary_key: :id


  def approve!
    ActiveRecord::Base.transaction do
      self.update_attributes(status: "APPROVED")
      overlapping_pending_requests.each do |pending_request|
        pending_request.deny!
      end
    end
  end

  def deny!
    self.update_attributes(status: "DENIED")
  end

  def overlapping_pending_requests
    requests = overlapping_requests
    pending_overlapping_requests = requests.select do |req|
      req.status == "PENDING"
    end
  end

 # private
  def overlapping_approved_requests
    requests = overlapping_requests
    approved_overlapping_requests = requests.select do |req|
      req.status == "APPROVED" && self.id != req.id
    end

    if approved_overlapping_requests.length > 0
      # self.deny!
      errors[:base] << "There is an overlapping rental."
    end
  end

  def overlapping_requests
    start_date = self.start_date
    end_date = self.end_date
    cat_id = self.cat_id
    request_id = self.id

    potential_overlaps = CatRentalRequest.find_by_sql([<<-SQL, request_id: request_id, start_date: start_date, end_date: end_date, cat_id: cat_id ] )

      SELECT
        c.*
      FROM
        cat_rental_requests c
      WHERE
        c.id <> :request_id
        AND
          c.cat_id = :cat_id
        AND (
          (c.start_date BETWEEN :start_date AND :end_date) OR
          (c.end_date BETWEEN :start_date AND :end_date)
        ) OR (
          (:start_date BETWEEN c.start_date AND c.end_date) OR
          (:end_date BETWEEN c.start_date AND c.end_date)
        )
    SQL
  end

end