class Post < ApplicationRecord

  belongs_to :user
  has_many :post_images, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_comments,dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :hashtag_posts, dependent: :destroy
  has_many :hashtags, through: :hashtag_posts


#PostImageのimageを取得
  accepts_attachments_for :post_images, attachment: :image

  enum category:{"公園": 0, "自然": 1, "ドッグラン": 2, "レストラン": 3, "カフェ": 4, "ショップ": 5, "宿泊施設": 6, "複合施設": 7, "牧場": 8, "道の駅": 9,"遊園地": 10,"美術館/博物館": 11,"その他": 12}

  validates :place, presence: true,
    length: { maximum: 255 }
  validates :address, presence: true
  validates :category, presence: true
  validates :body, presence: true,
    length: { maximum: 1000 }


#場所名と住所、説明からの部分検索
  def self.search(search)
    if search != ""
      Post.where(['place LIKE(?) OR address LIKE(?) OR body LIKE(?)', "%#{search}%", "%#{search}%","%#{search}%"])
    else
      Post.all
    end
  end

# 通知
  def create_notification_favorite!(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ", current_user.id, user_id, id, 'favorite'])
    # いいねされていない場合で、いいねした１度のみ、通知レコードを作成（押した数通知がいくのを防止）
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: 'favorite'
      )
      # 自分で行う自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_post_comment!(current_user, post_comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = PostComment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_post_comment!(current_user, post_comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_post_comment!(current_user, post_comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_post_comment!(current_user, post_comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      post_id: id,
      post_comment_id: post_comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

#ハッシュタグ
  after_create do
    post = Post.find_by(id: id)
    #hashbodyに打ち込まれたハッシュタグを検出
    hashtags =hashbody.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      #ハッシュタグは先頭の#を外した上で保存
      if hashtag.include?("#")
        tag = Hashtag.find_or_create_by(hashname: hashtag.delete('#'))
      elsif  hashtag.include?("＃")
        tag = Hashtag.find_or_create_by(hashname: hashtag.delete('＃'))
      end
      post.hashtags << tag
    end
  end

  before_update do
    post = Post.find_by(id: id)
    post.hashtags.clear
    hashtags = hashbody.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      if hashtag.include?("#")
        tag = Hashtag.find_or_create_by(hashname: hashtag.delete('#'))
      elsif  hashtag.include?("＃")
        tag = Hashtag.find_or_create_by(hashname: hashtag.delete('＃'))
      end
      post.hashtags << tag
    end
  end

end
