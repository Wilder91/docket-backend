class ProjectsController < ApplicationController

    def show 
        project = Project.find_by(id: params[:id])
        #binding.pry
        if project 
            render json: project, include: :milestones
        else 
           render json:  {message: "We Couldn't Find A Project With Those Credentials"}
        end 
    end 

    def index 
        #binding.pry
        projects = Project.all.sort { |a,b| a.due_date <=> b.due_date } 
        if projects 
            render json: projects, include: :milestones
        end
    end

    def toggle_complete
        #binding.pry
        project = Project.find_by(id: params[:id])
        project.complete = params[:complete]
        project.milestones.each {|m| m.complete = project.complete}
        project.save
    end

    def create 
        project = Project.find_or_create_by(name: params[:name])
        user = User.find_by(email: params[:user])
        project.kind  = params[:kind] 
        project.due_date = params[:date]
        project.user_id = params[:id]
        project.save
      
        if params[:template] != ""
            template = Template.find_by(name: params[:template])
            milestones = template.milestones
            milestones.each { |m| m["project_id"] = project.id}
            milestones.each { |m| m["id"] =nil}
            milestones.each { |m| m["created_at"] =nil}
            milestones.each { |m| m["updated_at"] =nil}
            #binding.pry
            
            milestones.each { |m| m["due_date"] = project.due_date - m["lead_time"]}
            list = milestones.each { |m| Milestone.create(m)}
            project.kind = template.name
        end
        #the above template code should more or less work once a user has decided on a template
        #certainly should be some refactoring available and the Template.all[0] will likely be 
        #replaced by a find_by function or similar
       
        project.save
        #binding.pry
        render json: project
    end

    def update 
        project = Project.find_by(id: params[:id])
        #binding.pry
        project.assign_attributes(name: params[:name], kind: params[:kind], due_date: params[:date], template: params[:template])
        project.save
        if project.template == true 
            #binding.pry
            Template.create(name: params[:kind], milestones: project.milestones, user_id: project.user.id)
        end
        render json: project

    end

    def delete 
        project = Project.find_by(id: params[:id])
        project.destroy

    end

    def user_projects 
        #binding.pry
        user = User.find_by(id: params[:id])
        projects = user.projects.all.sort { |a,b| a.due_date <=> b.due_date } 
        
        render json: projects, include: :milestones
    end

    private 

    def project_params 
        params.require(:project).permit(:name, :kind, :date, :user_id)
 
    end

end
