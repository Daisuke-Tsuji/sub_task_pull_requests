require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "invalid signup information" do
  #   assert_no_difference 'User.count' do
  #     post 'users/create', params: { user: { full_name:  "",
  #                                        user_name: "user",
  #                                        password:              "foo",
  #                                        password_confirmation: "bar" } }
  #   end
  #   assert_template 'devise/registrations/new'
  #   assert_select "div#error_explanation"
  # end
end
