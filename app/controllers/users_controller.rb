class UsersController < ApplicationController

    def show 
        #binding.pry
        user = User.find_by(id: params[:id])
        if user 
            render json: user
        else 
           render json: {message: "We Couldn't Find a User With Those Credentials"}
        end 
    end 

    def login 
        user = user.find_by(email: params[:email])
    end

    def create 
        #binding.pry
        user = User.find_by(email: params[:email])
        if user
            #binding.pry 
            user_id = user.id
        else 
            #binding.pry
            user = User.new
            user.email = params[:email]
            user.name = params[:name]
            user.save
        end
    end

    
end
