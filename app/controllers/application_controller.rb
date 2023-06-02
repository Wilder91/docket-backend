class ApplicationController < ActionController::API
  include JsonWebToken
  before_action :authorize_request
  

  
  private 
    def authorize_request
      header = request.headers['Authorization']
      #binding.pry
      header = header.split(' ').last if header
      decoded = JsonWebToken.decode(header)
      #binding.pry
      @current_user = User.find_by(id: decoded[:user_id])
      #binding.pry
    end
end