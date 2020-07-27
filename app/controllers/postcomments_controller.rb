class PostcommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :sign_in_required

  def create
    @post = Micropost.find(params[:micropost_id])
    @postcomment = @post.postcomments.build(postcomment_params)
    @postcomment.user_id = current_user.id
    @comment_item = @postcomment.micropost
    if @postcomment.save
      @comment_item.create_notification_postcomment!(current_user, @postcomment.id)
      flash[:notice] = "コメントしました"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "コメントできませんでした"
      redirect_back(fallback_location: root_path)
    end
  end

  private

    def postcomment_params
      params.require(:postcomment).permit(:content)
    end
end
