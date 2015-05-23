require "test_helper"

class Api::UsersControllerTest < ActionController::TestCase

  def user
    @user ||= users(:pdawczak)
  end

  def test_index
    get :index, format: :json
    assert_response :success
    assert_not_nil assigns(:users)
  end

  def test_create
    assert_difference('User.count') do
      post :create, user: { email: "sample@email.com", password: "testingsuper" }, format: :json
    end

    assert_response :created
  end

  def test_show
    get :show, id: user, format: :json
    assert_response :success
  end

  def test_update
    put :update, id: user, user: { email: "different@email.com" }, format: :json
    assert_response :success
  end

  def test_destroy
    assert_difference('User.count', -1) do
      delete :destroy, id: user, format: :json
    end

    assert_response :no_content
  end
end
