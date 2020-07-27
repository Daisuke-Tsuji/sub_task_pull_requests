class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  #フォローの通知
  def create_notification_follow!(current_user)
    temp = Notification.where(["visiter_id = ? and visited_id = ? and action = ? ",current_user.id, followed_id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: followed_id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end
end
