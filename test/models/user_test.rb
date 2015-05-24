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

  def test_legacy_new
    user = User.new(firstNames: "Joe",
                    middleNames: "von",
                    lastNames: "Tester")

    assert_equal "Joe",    user.first_names
    assert_equal "von",    user.middle_names
    assert_equal "Tester", user.last_names
  end

  def test_legacy_update
    user.update(firstNames:  "Updated FirstNames",
                middleNames: "Updated MiddleNames",
                lastNames:   "Updated LastNames")

    assert_equal "Updated FirstNames",  user.first_names
    assert_equal "Updated MiddleNames", user.middle_names
    assert_equal "Updated LastNames",   user.last_names
  end
end
