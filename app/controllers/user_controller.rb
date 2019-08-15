class UserController < ApplicationController
  def index
    @users = User.all
    render json: @users
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: {status: 200, message: '登録完了'}
    else
      render json: {status: 400, message: @user.errors.full_messages}
    end
  end

  def login
    user = User.find_by(email: params[:email], password: params[:password])
    if user
      render json: {access_token: JWT.encode(user, Rails.application.credentials.secret_key_base)}
    else
      render json: {status: 401, message:"認証失敗"}
    end
  end

  private

  def user_params
    params.fetch(:user, {}).permit(:name, :description, :email, :password)
  end
end
