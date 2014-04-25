class Cat < ActiveRecord::Base

  has_many :rentals,
    class_name: "CatRentalRequest",
    foreign_key: :cat_id,
    primary_key: :id,
    dependent: :destroy

    belongs_to :owner,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: "User"

  validates :age, :birthdate, :color, :name, :sex, presence: true
  validates :sex, inclusion: { in: [ "M", "F"]  }
  validates :color, inclusion: { in: [ "calico", "tabby", "solid"]  }
  validates :age, numericality: true

end