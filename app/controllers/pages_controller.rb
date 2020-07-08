class PagesController < ApplicationController
  before_action :sign_in_required


  def index
    @user = User.all.where.not(id: current_user.id)
  end

  def show
    @user = User.find(current_user.id)
    @micropost = current_user.microposts
  end

  def edit
  end
end
