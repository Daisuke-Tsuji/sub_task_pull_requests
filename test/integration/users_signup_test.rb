require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "sigup_user_success" do
     get new_user_registration_path
     assert_difference 'User.count', 1 do
      post '/users', params: { user: {   full_name:  "Example User",
                                         user_name: "example",
                                         password:              "password",
                                         password_confirmation: "password" } }
     assert_redirected_to root_path
    end
  end

  test "invalid signup information" do
    get new_user_registration_path
    assert_no_difference 'User.count' do
      post '/users', params: { user: {  full_name:  "",
                                        user_name: "user@invalid",
                                        password:              "foo",
                                        password_confirmation: "bar" } }
    end
   assert_template 'registrations/new'
   assert_template 'devise/shared/_error_messages'
  end
end
