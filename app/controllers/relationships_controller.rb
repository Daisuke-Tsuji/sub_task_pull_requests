class RelationshipsController < ApplicationController

  def follow
    @user = current_user.follow(params[:id])
    @user.create_notification_follow!(current_user)
    redirect_to root_path
  end

  def unfollow
    current_user.unfollow(params[:id])
    redirect_to root_path
  end

end
