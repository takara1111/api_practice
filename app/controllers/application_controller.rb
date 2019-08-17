class ApplicationController < ActionController::API
  

    private

    def authenticate
      if request.headers["Authenticate"].present?
        token = request.headers['Authorization'].split(' ').last
        user_data = JWT.decode(token, Rails.application.credentials.secret_key_base,)[0]
      else
        render json: {status: 401, message: "ログインしろ"}
      end
    end

    def authenticated_user
      @authenticated_user = User.find_by(email: authenticate["email"])
    end

end
