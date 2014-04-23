class Cat < ActiveRecord::Base

  validates :age, :birth_date, :color, :name, :sex, presence: true
  validates :sex, inclusion: { in: [ "M", "F"]  }
  validates :color, inclusion: { in: [ "calico", "tabby", "solid"]  }
  validates :age, numericality: true

end