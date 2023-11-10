class AuthenticationController < ApplicationController
  before_action :authorize_request, except: :login

  def login
    if params[:google_token].present?
      handle_google_login
    else
      handle_email_password_login
    end
  end
  
  private
  
  def handle_google_login
    #binding.pry
    google_user = User.from_google(params[:google_token])
    #binding.pry
    if google_user
      handle_successful_login(google_user)
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
    token = JsonWebToken.encode(user_id: user.id)
    time = Time.now + 12.hours.to_i
  
    render json: { token: token, exp: time.strftime('%m-%d-%Y %H:%M'), email: user.email }, status: :ok
  end
  
  def handle_unauthorized_error
    render json: { error: 'unauthorized' }, status: :unauthorized
  end
  private

  def login_params
    params.permit(:email, :password)
  end
end