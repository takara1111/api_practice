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

  private

  def user_params
    params.fetch(:user, {}).permit(:name, :description, :email, :password)
  end
end
