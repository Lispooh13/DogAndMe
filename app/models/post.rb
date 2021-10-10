class Post < ApplicationRecord
  
  belongs_to :user
  has_many :post_images, dependent: :destroy
  
  #PostImageのimageを取得
  accepts_attachments_for :post_images, attachment: :image
end
