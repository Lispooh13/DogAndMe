class Post < ApplicationRecord
  
  belongs_to :user
  has_many :post_images, dependent: :destroy
  
  #PostImageのimageを取得
  accepts_attachments_for :post_images, attachment: :image
  
  enum purpose:{"遊ぶ": 0, "撮影": 1,"飲食": 2,"買い物": 3,"その他": 4}
  
end
