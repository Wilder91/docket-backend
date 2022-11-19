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
        projects = Project.all.sort { |a,b| a.due_date <=> b.due_date } 
        if projects 
            render json: projects, include: :milestones
        end
    end

    def create 
        project = Project.find_or_create_by(name: params[:name])
        user = User.find_by(email: params[:user])
        project.kind  = params[:kind] 
        project.due_date = params[:date]
        #binding.pry
        project.user_id = params[:id]
        
        project.save
        render json: project
    end

    def delete 
        project = Project.find_by(id: params[:id])
        project.destroy

    end

    def user_projects 
        #binding.pry
        user = User.find_by(id: params[:id])
        
        if user
            projects = user.projects.all.sort { |a,b| a.due_date <=> b.due_date } 
            render json: projects, include: :milestones
        else 
            render json: {message: "We Couldn't Find a User With Those Credentials"}
         end 
    end

    private 

    def project_params 
        params.require(:project).permit(:project_name, :kind, :due_date, :user_id)
 
    end

end
