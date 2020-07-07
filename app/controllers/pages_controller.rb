class PagesController < ApplicationController
  before_action :sign_in_required

  
  def index
  end

  def show
    @user = User.find(current_user.id)
    @micropost = current_user.microposts
  end

  def edit
  end
end
