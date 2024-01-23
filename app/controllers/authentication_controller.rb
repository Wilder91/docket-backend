class AuthenticationController < ApplicationController
  before_action :authorize_request, except: :login

  def login
    #binding.pry
    if params[:google_token].present?
      handle_google_login
    else
      handle_email_password_login
    end
  end
  
  private
  
  def handle_google_login
    token = params[:google_token]
    google_user = User.from_google(token)
  
    if google_user
      # Assuming `google_user.token` holds the Google token
      render json: { token: token }
    else
      handle_unauthorized_error
    end
  end
  
  def handle_email_password_login
    @user = User.find_by(email: login_params[:email])
    #binding.pry
    if @user&.authenticate(login_params[:password])
      handle_successful_login(@user)
    else
      handle_unauthorized_error
    end
  end
  
  def handle_successful_login(user)
    #binding.pry
    
    begin
      token = JsonWebToken.encode(user_id: user.id)
      time = Time.now + 12.hours.to_i
    
      render json: { token: token, exp: time.strftime('%m-%d-%Y %H:%M'), email: user.email }, status: :ok
    rescue => e
      render json: { error: 'Token generation failed' }, status: :unprocessable_entity
      # Optionally, you can log the error for debugging purposes
      Rails.logger.error("Token generation error: #{e.message}")
    end
  end
  
  def handle_unauthorized_error
    render json: { error: 'unauthorized' }, status: :unauthorized
  end
  private

  def login_params
    params.permit(:email, :password)
  end
end