require "test_helper"

class UserTest < ActiveSupport::TestCase
  def user
    @user ||= users(:joe)
  end

  def test_valid
    assert user.valid?
  end

  def test_user_attributes
    assert_respond_to user, :email
    assert_respond_to user, :title
    assert_respond_to user, :first_names
    assert_respond_to user, :middle_names
    assert_respond_to user, :last_names
    assert_respond_to user, :dob
  end
end
