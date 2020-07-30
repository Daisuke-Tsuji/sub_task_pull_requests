class LikesController < ApplicationController
  before_action :sign_in_required

  def create
    @like = current_user.likes.create(micropost_id: params[:micropost_id])
    @micropost = Micropost.find(params[:micropost_id])
    @micropost.create_notification_by(current_user)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @like = Like.find_by(micropost_id: params[:micropost_id], user_id: current_user.id)
    @like.destroy
    redirect_back(fallback_location: root_path)
  end
end
