class ApplicationController < ActionController::API
  #checking to confirm that the user is actually logged in
  #checking to see if you have a valide token
  def authorize
    begin 
      #once a user logs in, you send a fetch request to the backend, and a token with the fetch request
      #handle the token on the backend
      header = request.headers['Authorization']
      #splitting off the word "Bearer", token is at index 1
      token = header.split(" ")[1]
      secret = Rails.application.secret_key_base
      payload = JWT.decode(token, secret)
      #when JWT decodes, it takes out user_id and pass it into the find to locate that user in the database
      @user = User.find(payload['user_id'])
    rescue 
      render json: {error: "Authorization Failed"}
    end
  end
end
