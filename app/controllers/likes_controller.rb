class LikesController < ApplicationController
  def create
    @like = current_user.likes.create(micropost_id: params[:micropost_id])
    @micropost = Micropost.find(params[:micropost_id])
      #通知の作成
    @micropost.create_notification_by(current_user)
    respond_to do |format|
      format.html {redirect_to request.referrer}
      format.js
    end
    #redirect_back(fallback_location: root_path)
  end

  def destroy
    @like = Like.find_by(micropost_id: params[:micropost_id], user_id: current_user.id)
    @like.destroy
    redirect_back(fallback_location: root_path)
  end
end
