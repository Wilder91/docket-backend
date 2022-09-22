class UsersController < ApplicationController

    def show 
        user = User.find_by(id: params[:id])
        if user 
            render json: user
        else 
           render json: {message: "We Couldn't Find a User With Those Credentials"}
        end 
    end 

    def index 
        users = User.all 
        render json: users

    end

    def login 
        user = user.find_by(email: params[:email])
    end

    def create 
        
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

    
end
