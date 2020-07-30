module NotificationsHelper

  def notification_form(notification)
    @visiter = notification.visiter
    @comment = nil
    your_item = link_to 'あなたの投稿', micropost_path(notification), style:"font-weight: bold;"
    @visiter_comment = notification.postcomment_id
    #notification.actionがfollowかlikeかcommentか
    case notification.action
      when "follow" then
        tag.a(notification.visiter.user_name, href:page_path(@visiter), style:"font-weight: bold;")+"があなたをフォローしました"
      when "like" then
        tag.a(notification.visiter.user_name, href:page_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:micropost_path(notification.micropost_id), style:"font-weight: bold;")+"にいいねしました"
      when "postcomment" then
          @comment = Postcomment.find_by(id: @visiter_comment)&.content
          tag.a(@visiter.user_name, href:page_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:micropost_path(notification.micropost_id), style:"font-weight: bold;")+"にコメントしました"
    end
  end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end
