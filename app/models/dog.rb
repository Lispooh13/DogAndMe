class Dog < ApplicationRecord
  belongs_to :user

  enum dog_size:{"小型犬": 0, "中型犬": 1, "大型犬": 2}


  validates :name, presence: true
  validates :dog_size, presence: true
  validates :dog_type, presence: true

end
