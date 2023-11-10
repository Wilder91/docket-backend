class UsersController < ApplicationController
  before_action :authorize_request, except: [:create, :index, :delete]
  before_action :find_user, except: %i[create index]

  # GET /users
  def index
    #binding.pry
    @users = User.all
    render json: @users, include: [:projects, :milestones, :templates], status: :ok
  end

  # GET /users/{id}
  def show
    render json: @user, include: [:projects, :milestones, :templates], status: :ok
  end

  # POST /users
  def create
    
    user = User.new(name: params["name"], email: params["email"], password: params["password"])
    if user.save
      render json: user, status: :created
    else
      render json: { errors: "Validation failed: #{user.errors.full_messages.join(', ')}" },
             status: :unprocessable_entity
    end
  end

  

  # PUT /users/{id}
  def update
    #binding.pry
    @user.name = params['name']
    @user.email = params['email']
    if @user.save
      render json: @user
    else
      render json: { errors: "Validation failed: #{user.errors.full_messages.join(', ')}" },
             status: :unprocessable_entity
    end
  end

  
  # DELETE /users/{id}
  def delete
    #binding.pry
    
    @user.destroy
  end

  private

  def find_user
    @user = User.find_by!(id: params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'User not found' }, status: :not_found
  end
end