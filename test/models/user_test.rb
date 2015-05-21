require "test_helper"

class UserTest < ActiveSupport::TestCase
  def user
    @user ||= users(:pdawczak)
  end

  def test_valid
    assert user.valid?
  end
end
