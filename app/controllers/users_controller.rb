class UsersController < ApplicationController
    before_action :authorize_request, except: :create
    before_action :find_user, except: %i[create index]
  
    # GET /users
    def index
      #binding.pry
      @users = User.all
      render json: @users, status: :ok
    end
  
    # GET /users/{username}
    def show
      #binding.pry
      @user = User.find_by(id: params[:id])
      
      render json: @user, include: [:projects, :milestones], status: :ok
    end
  
    # POST /users
    def create
      @user = User.find_or_create_by(user: user_params)
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