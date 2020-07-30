require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(full_name: "Example User", user_name: "example",
                     password: "foobar", password_confirmation: "foobar",
                     email: "", website: "", introduction: "", phone: "",
                     gender: "0" )
  end

    test "should be valid full_name presence" do
      @user.full_name = " "
      assert_not @user.valid?
    end

    test "should be valid user_name presence" do
      @user.user_name = " "
      assert_not @user.valid?
    end

    test "should be valid names length" do
      @user.full_name = "a" * 51
      assert_not @user.valid?
      @user.full_name = "Example User"
      assert @user.valid?
      @user.user_name = "a" * 51
      assert_not @user.valid?
    end

    test "should be valid password blank and shot" do
      @user.password = " "
      assert_not @user.valid?
      @user.password = "sss"
      assert_not @user.valid?
    end

    test "should be valid password not match" do
      @user.password = "555555"
      @user.password_confirmation = "777777"
      assert_not @user.valid?
    end

    test "should be valid email length" do
      @user.email = "aaa"
      assert_not @user.valid?
      @user.email = "a" *244 + "@example.com"
      assert_not @user.valid?
    end

    test "should be valid introduction length" do
      @user.introduction = "a" * 151
      assert_not @user.valid?
    end

    test "should be valid phone length and fomat" do
      @user.phone = "0" * 9
      assert_not @user.valid?
      @user.phone = "2" * 12
      @user.phone = "090-0000-0000"
      assert_not @user.valid?
      @user.phone = "aaa99998772"
      assert_not @user.valid?
    end

end
