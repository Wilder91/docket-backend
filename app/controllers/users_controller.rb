class UsersController < ApplicationController
    before_action :authorize_request, except: [:create, :index]
    before_action :find_user, except: %i[create index]
  
    # GET /users
    def index
      #binding.pry
      @users = User.all
      #binding.pry
      render json: @users, include: [:projects, :milestones, :templates], status: :ok
    end
  
    # GET /users/{username}
    def show
      #binding.pry
      @user = User.find_by(id: params[:id])
      
      render json: @user, include: [:projects, :milestones], status: :ok
    end
  
    # POST /users
    def create 
      #binding.pry
      @user = User.find_or_create_by(name: user_params[:name])
      @user.email = user_params[:email]
      @user.password = user_params[:password]
      if @user.save
        render json: @user, status: :created
      else
        render json: { errors: @user.errors.full_messages },
               status: :unprocessable_entity
      end
    end
  
    # PUT /users/{username}
    def update
      unless @user.update(user_params)
        render json: { errors: @user.errors.full_messages },
               status: :unprocessable_entity
      end
    end
  
    # DELETE /users/{username}
    def destroy
      @user.destroy
    end
  
    private
  
    def find_user
      @user = User.find_by(email: params[:email])
      rescue ActiveRecord::RecordNotFound
        render json: { errors: 'User not found' }, status: :not_found
    end
  
    def user_params
      params.permit(
        :name,  :email, :password, :user
      )
    end
  end