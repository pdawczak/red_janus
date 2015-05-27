class Api::UsersController < ApplicationController
  before_action :set_user, except: [:index, :search]

  # GET /api/users
  # GET /api/users.json
  def index
    @users = User.all
  end

  def search
    @users = User.search(params[:term])
    render :index
  end

  # GET /api/users/1
  # GET /api/users/1.json
  def show
  end

  # POST /api/users
  # POST /api/users.json
  def create
    @user = User.new(user_params)

    if @user.save
      render :show, status: :created, location: [:api, @user]
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/users/1
  # PATCH/PUT /api/users/1.json
  def update
    if @user.update(user_params)
      render :show, status: :ok, location: [:api, @user]
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update_name
    if @user.update(params.permit(:title, :firstNames, :middleNames, :lastNames))
      render :show, status: :ok, location: [:api, @user]
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update_password
    if @user.update(params.permit(:plainPassword))
      head :no_content
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update_enabled
    if @user.update(params.permit(:enabled))
      head :no_content
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update_email
    if @user.update(params.permit(:email))
      head :no_content
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update_dob
    if @user.update(params.permit(:dob))
      head :no_content
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/users/1
  # DELETE /api/users/1.json
  def destroy
    @user.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find_by_username(params[:username])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.permit(:email, :plainPassword, :title, :firstNames,
                    :middleNames, :lastNames, :dob)
    end
end
