class MicropostsController < ApplicationController
  before_action :sign_in_required


 def new
   @user = User.find(current_user.id)
   @micropost = @user.microposts.build
   @micropost.image = "micropost.jpg"
 end

 def show
   @micropost = Micropost.find_by(id:params[:id])
   @like = Like.new
   @postcomments = @micropost.postcomments
   @postcomment = @micropost.postcomments.build
 end


 def create
   @micropost = current_user.microposts.build(micropost_params)
   if @micropost.save
     flash[:notice] = "投稿しました"
     redirect_to page_path(current_user)
   else
     render 'microposts/new'
   end
 end

 def destroy
 end

 def search
    #Viewのformで取得したパラメータをモデルに渡す
    @search_posts = Micropost.search(params[:search])
 end


 private
  def micropost_params
   params.require(:micropost).permit(:comment, :image)
  end
end
