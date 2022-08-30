class ProjectsController < ApplicationController

    def show 
        project = Project.find_by(id: params[:id])
        if project 
            render json: project, include: :milestones
        else 
           render json:  "We Couldn't Find A Project With Those Credentials"
        end 
    end 

    def index 
        #binding.pry
        projects = Project.all 
        if projects 
            render json: projects, include: :milestones
        end
    end

    def create 
        #binding.pry
        project = Project.find_or_create_by(name: params[:name])
        user = User.find_by(email: params[:user])
        project.kind  = params[:kind] 
        project.due_date = params[:date]
        project.user_id = 1 
        #binding.pry
        project.save
    end

    def delete 
        #binding.pry
        project = Project.find_by(id: params[:id])
        #binding.pry
        project.destroy

    end

    def user_projects 
        #binding.pry
        user = User.find_by(id: params[:id])
        projects = user.projects.all
        #binding.pry
        render json: projects, include: :milestones
    end

    private 

    def project_params 
        params.require(:project).permit(:project_name, :kind, :due_date, :user_id)
 
    end

end
