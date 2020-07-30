require 'test_helper'

class UserEditTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers

  def setup
    @edit_user = users(:daisuke)
    login_as(@edit_user, scope: :user)
  end

  test "user_edit_succese" do
    get profile_edit_path
    assert_template 'registrations/profile_edit'
    patch profile_update_path , params: {user: { full_name:  "daisuke",
                                           user_name:  "tsuji",
                                           email:      "daisuke@gmail.com",
                                           } }
    assert_redirected_to page_path(@edit_user)
  end

  test "user_edit_failures" do
    get profile_edit_path
    assert_template 'registrations/profile_edit'
    patch profile_update_path , params: {user: { full_name:  "",
                                           user_name:  "",
                                           email:      "daisuke@gmail.com",
                                           } }
    assert_template 'devise/registrations/profile_edit'
  end
end
