class ApplicationController < ActionController::API
  

    private

    def authenticate
      if request.headers["Authenticate"].present?
        token = request.headers['Authorization'].split(' ').last
        @user = JWT.decode(token, Rails.application.credentials.secret_key_base, true, { algorithm: 'HS256' })[0]
      else
        render json: {status: 401, message: "ログインしろ"}
      end
    end
end
