class UsersController < ApplicationController

  def show 
      user = User.find_by(id: params[:id]) 
      
      if user 
          render json: user, :include => { :projects => {:include =>:milestones} }
      else 
         render json: {message: "We Couldn't Find a User With Those Credentials"}
      end 
  end 

  def login 
 

  end

  def create 
      user = User.find_by(email: params[:email])
      if user 
          user_id = user.id
      else 
          user = User.new
          user.email = params[:email]
          user.password = params[:password]
          user.save
      end
  end

  

  

  def index 
      users = User.all
      render json: users, :include => { :projects => {:include =>:milestones}}
  end

  private

  def user_params 
      params.require(:user).permit(:name, :email)
  end



  
end