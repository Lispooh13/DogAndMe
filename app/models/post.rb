class Post < ApplicationRecord

  belongs_to :user
  has_many :post_images, dependent: :destroy

  #PostImageのimageを取得
  accepts_attachments_for :post_images, attachment: :image

  enum purpose:{"遊ぶ": 0, "写真を撮る": 1,"飲食": 2,"買い物": 3,"その他": 4}

  validates :place, presence: true
  validates :address, presence: true
  validates :purpose, presence: true
  validates :body, presence: true

  def self.search(search)
    if search != ""
    Post.where('place LIKE(?)', "%#{search}%")
    else
    Post.page(params[:page]).reverse_order
    end
  end

end
