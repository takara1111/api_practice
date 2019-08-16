class UsersController < ApplicationController
  # 登録
  # curl --request POST --url http://localhost:3000/users --header 'Content-Type: application/json' --data '{"name": "test2","description": "des3", "email": "","password": ""}'

  # curl -X POST --url http://localhost:3000/users --header 'Content-Type: application/json' -d '{"name": "test6", "email": "test7@test.com","password": "password"}'

  # ログイン
  # curl --request POST --url http://localhost:3000/users/login --header 'Content-Type: application/json' --data '{"email":"test1@test.com","password": "password"}'

# 一覧
  # curl --request GET --url http://localhost:3000/users --header 'Content-Type: application/json'

  # 詳細
  # curl -X GET --url http://localhost:3000/users/1 --header 'Content-Type: application/json'


  # curl -X GET --url http://localhost:3000/todos --header 'Authorization: Basic eyJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6ImNvY29va2luZ0BsaXZlLmpwIiwicGFzc3dvcmQiOiJjb2Nvb2tpbmcifQ.X5TV5RG_SlFSUl_8-QU3n5PixmVpex2Nsp1ziWryeXc' --header 'Content-Type: application/json'
  
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

    def authenticate
      if request.headers["Authorization"].present?
        token = request.headers['Authorization'].split(' ').last
        @user = JWT.decode(token, Rails.application.credentials.secret_key_base)
      end
    end

    def user_params
      params.fetch(:user, {}).permit(:name, :description, :email, :password)
    end
end
