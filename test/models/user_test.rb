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
    user = User.new(firstNames:  "Joe",
                    middleNames: "von",
                    lastNames:   "Tester")

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

  def test_initials
    user = User.new(first_names:  "Joe",
                    middle_names: "von",
                    last_names:   "Test")
    assert_equal "jvt", user.initials

    user = User.new(first_names: "Joe",
                    last_names:  "Test")
    assert_equal "jt", user.initials
  end

  def test_set_username
    user_attributes = { email:        "test_example@tesgint.com",
                        title:        "Mr",
                        first_names:  "Joe",
                        middle_names: "von",
                        last_names:   "Testinger",
                        password:     "supertestpass",
                        dob:          Date.parse("1967-09-01") }

    user = User.create(user_attributes)
    assert_equal "jvt2", user.username

    user_attributes.merge!(email: "another_email@test.com", 
                           username: "zxc123")

    user = User.create(user_attributes)
    assert_equal "jvt3", user.username
  end
end
