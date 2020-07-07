class PagesController < ApplicationController
  def index
  end

  def show
    @user = User.find(current_user.id)
    @micropost = @user.microposts
  end

  def edit
  end
end
