class RelationshipsController < ApplicationController
  before_action :sign_in_required

  def follow
    @user = current_user.follow(params[:id])
    @user.create_notification_follow!(current_user)
    redirect_to page_path(@user.followed_id)
  end

  def unfollow
    current_user.unfollow(params[:id])
    redirect_to page_path(params[:id])
  end

end
