class UsersController < ApplicationController

  def show 
      user = User.find_by(id: params[:id])
      params[:id] = localStorage.user_id
      if user 
          render json: user
      else 
         render json: {message: "We Couldn't Find a User With Those Credentials"}
      end 
  end 

  def login 
    binding.pry

  end

  def create 
      #binding.pry
      user = User.find_by(email: params[:email])
      if user 
          user_id = user.id
      else 
          user = User.new
          user.email = params[:email]
          user.name = params[:name]
          user.save
      end
  end

  

  

  def index 
      users = User.all
      render json: users
  end

  private

  def user_params 
      params.require(:user).permit(:name, :email)
  end



  
end