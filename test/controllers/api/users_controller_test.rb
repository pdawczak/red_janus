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

  def test_search
    get :search, term: "jo", format: :json
    assert_response :success
    assert_includes assigns(:users), users(:joe)

    get :search, term: "baz", format: :json
    assert_response :success
    assert_not_includes assigns(:users), users(:joe)

    get :search, term: "sue", format: :json
    assert_response :success
    assert_not_includes assigns(:users), users(:sue)
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

  def test_update_name
    user_params = { title:       "Dr",
                    firstNames:  "John",
                    middleNames: "at",
                    lastNames:   "Ruby" }

    put :update_name, { username: user.username, format: :json }.merge(user_params)
    assert_response :success
    assert_equal "Dr",   assigns(:user).title
    assert_equal "John", assigns(:user).first_names
    assert_equal "at",   assigns(:user).middle_names
    assert_equal "Ruby", assigns(:user).last_names

    user_params = { title:       "Dr",
                    firstNames:  "",
                    middleNames: "at",
                    lastNames:   nil}

    put :update_name, { username: user.username, format: :json }.merge(user_params)
    assert_response :unprocessable_entity
    assert_includes assigns(:user).errors.messages, :first_names
    assert_includes assigns(:user).errors.messages, :last_names
  end

  def test_update_password
    put :update_password, { username: user.username, format: :json }.merge({ plainPassword: "SupErTest1234" })
    assert_response :no_content

    put :update_password, { username: user.username, format: :json }.merge({ plainPassword: "pass" })
    assert_response :unprocessable_entity
    assert_includes assigns(:user).errors.messages, :password
  end

  def test_update_enabled
    put :update_enabled, { username: user.username, format: :json }.merge({ enabled: false })
    assert_response :no_content
  end

  def test_destroy
    assert_difference('User.count', -1) do
      delete :destroy, username: user.username, format: :json
    end

    assert_response :no_content
  end
end
