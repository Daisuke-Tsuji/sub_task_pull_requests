class Micropost < ApplicationRecord
  has_many :postcomments
  belongs_to :user
  has_many :likes
  has_many :liked_users, through: :likes, source: :user
  has_many :notifications, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  mount_uploader :image, ImageUploader
  validates :user_id, presence: true
  validates :comment, length: { maximum: 2200 }
  validates :image,   presence: true

  #検索にて、投稿内容と完全一致するものを表示
  def self.search(search)
    return Micropost.all unless search
    Micropost.where(['comment LIKE ?', "%#{search}%"])
  end

  #いいねの通知
  def create_notification_by(current_user)
    notification = current_user.active_notifications.new(
      micropost_id: id,
      visited_id: user_id,
      action: "like"
    )
    notification.save if notification.valid?
  end

  #コメントの通知
  def create_notification_postcomment!(current_user, postcomment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Postcomment.select(:user_id).where(micropost_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
        save_notification_comment!(current_user, postcomment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, postcomment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, postcomment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      micropost_id: id,
      postcomment_id: postcomment_id,
      visited_id: visited_id,
      action: 'postcomment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visiter_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
