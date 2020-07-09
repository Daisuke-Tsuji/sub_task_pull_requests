class PagesController < ApplicationController
  before_action :sign_in_required, only: [:show, :edit]
  before_action :set_user, only: [:show]


  def index
    if user_signed_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed
    else
      @user = User.all
    end
  end

  def show
    @micropost = @user.microposts
  end

  def edit
  end

  private

    def set_user
      @user = User.find(params[:id])
    end
end
