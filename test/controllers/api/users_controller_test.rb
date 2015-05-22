require "test_helper"

class Api::UsersControllerTest < ActionController::TestCase

  def user
    @user ||= users(:pdawczak)
  end

  def test_index
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  def test_new
    get :new
    assert_response :success
  end

  def test_create
    assert_difference('User.count') do
      post :create, user: { email: "sample@email.com", password: "testingsuper" }
    end

    assert_redirected_to api_user_path(assigns(:user))
  end

  def test_show
    get :show, id: user
    assert_response :success
  end

  def test_edit
    get :edit, id: user
    assert_response :success
  end

  def test_update
    put :update, id: user, user: { email: "different@email.com" }
    assert_redirected_to api_user_path(assigns(:user))
  end

  def test_destroy
    assert_difference('User.count', -1) do
      delete :destroy, id: user
    end

    assert_redirected_to api_users_path
  end
end
