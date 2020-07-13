class AuthenticationController < ApplicationController

  def login
    @user = User.find_by(username: params[:username])

    if !@user 
      render json: { error: "Authentication Failed"}

    else
      #going to bcrypt, if it doesnt authenticate the password correctly do this thing
      if !@user.authenticate params[:password]
        render json: { error: "Authentication Failed!!!"}

      else
        #when you send a JWT token the payload for this will be the user id
        payload = { user_id: @user.id}
        #new random secret key every rails session 
        secret = Rails.application.secret_key_base
        token = JWT.encode(payload, secret)
        render json: { token: token }
      end
    end
  end
end
