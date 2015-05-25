require "test_helper"

class Api::UsersControllerTest < ActionController::TestCase

  def user
    @user ||= users(:joe)
  end

  def test_index
    get :index, format: :json
    assert_response :success
    assert_not_nil assigns(:users)
  end

  def test_create
    user_params = {
      plainPassword: "testinguser",
      email:         "sample@email.com",
      title:         "Mr",
      firstNames:    "Joe",
      middleNames:   "von",
      lastNames:     "Tester",
      dob:           "1978-07-10"
    }

    assert_difference('User.count') do
      post :create, { format: :json }.merge(user_params)
    end

    assert_response :created
  end

  def test_show
    get :show, username: user.username, format: :json
    assert_response :success
  end

  def test_update
    user_params = {
      email: "different@email.com",
      plainPassword: "$uperTest!"
    }

    put :update, { username: user.username, format: :json }.merge(user_params)
    assert_response :success
  end

  def test_destroy
    assert_difference('User.count', -1) do
      delete :destroy, username: user.username, format: :json
    end

    assert_response :no_content
  end
end
