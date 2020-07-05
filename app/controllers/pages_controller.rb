class PagesController < ApplicationController
  def index
  end

  def show
  end

  def edit
    @user = User.find(current_user.id)
  end
end
