class PostcommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    post = Micropost.find(params[:micropost_id])
    @postcomment = post.postcomments.build(postcomment_params)
    @postcomment.user_id = current_user.id
    if @postcomment.save
      flash[:success] = "コメントしました"
      redirect_back(fallback_location: root_path)
    else
      flash[:success] = "コメントできませんでした"
      redirect_back(fallback_location: root_path)
    end
  end

  private

    def postcomment_params
      params.require(:postcomment).permit(:content)
    end
end
