class Post < ApplicationRecord

  belongs_to :user
  has_many :post_images, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_comments,dependent: :destroy


  #PostImageのimageを取得
  accepts_attachments_for :post_images, attachment: :image

  enum purpose:{"遊ぶ": 0, "写真を撮る": 1, "飲食": 2, "買い物": 3, "泊まる": 4, "その他": 5}

  validates :place, presence: true
  validates :address, presence: true
  validates :purpose, presence: true
  validates :body, presence: true


  def self.search(search)
    if search != ""
      Post.where(['place LIKE(?) OR address LIKE(?) OR purpose LIKE(?) OR body LIKE(?)', "%#{search}%", "%#{search}%","%#{search}%","%#{search}%"])
    else
      Post.all
    end
  end

end
