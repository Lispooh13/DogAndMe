class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         validates :name, presence: true
  attachment :profile_image

  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :dogs, dependent: :destroy

# フォロー・フォロワー
  #フォローしているuser達
  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follow
  #フォローされているuser達
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :user

  #ユーザーをフォローする
  def follow(user_id)
    relationships.create(follow_id: user_id)
  end

  #ユーザーのフォローを外す
  def unfollow(user_id)
    relationships.find_by(follow_id: user_id).destroy
  end

  #フォローしていればtrueを返す
  def following?(user)
    followings.include?(user)
  end


# 通知機能
  # 自分からの通知
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  # 相手からの通知
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  def create_notification_follow!(current_user)
    # フォローされているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    # フォローされていない場合、同じ通知レコードが存在しないときのみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end


end