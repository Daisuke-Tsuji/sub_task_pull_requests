class ApplicationController < ActionController::Base


#新規アカウント作成後users/showへ
 def after_sign_in_path_for(resource)
   @user
 end

 private
   def sign_in_required
     redirect_to new_user_session_url unless user_signed_in?
   end
end
