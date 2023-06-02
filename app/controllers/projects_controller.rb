class ProjectsController < ApplicationController
    before_action :find_project, only: [:show, :update, :delete]
  
    def show 
      render json: @project, include: :milestones
    end 
  
    def index 
      projects = Project.all.sort_by(&:due_date)
      render json: projects, include: :milestones
    end
  
    def toggle_complete
      project = Project.find_by(id: params[:id])
      project.complete = params[:complete]
      project.milestones.each {|m| m.complete = project.complete}
      project.save
    end
  
    def create
      project = Project.new(project_params)
      project.due_date = params[:due_date]
      if project.save
        create_from_template(project, params[:template])
        render json: project, include: :milestones
      else
        render json: { errors: project.errors.full_messages }, status: :unprocessable_entity
      end
    end
    
    def update
      if @project.update(project_params)
        render json: @project
      else
        render json: { errors: @project.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
   
  
    def delete 
        project = Project.find_by(id: params["id"])
        project.destroy
      
     
    end
  
    def user_projects 
      user = User.find_by(id: params[:id])
      projects = user.projects.all.sort_by(&:due_date)
      render json: projects, include: :milestones
    end
  
    private 
  
    def project_params 
      params.require(:project).permit(:name, :kind, :due_date, :user_id)
    end
  
    def find_project
      begin
        @project = Project.find_by(id: params[:id])
        unless @project
          render json: { error: 'Project not found' }, status: :not_found
        end
      rescue => e
        render json: { error: e.message }, status: :internal_server_error
      end
    end
  
    def create_from_template(project, template_name)
        
      return unless template_name.present?
  
      template = Template.find_by(name: template_name)
      return unless template
      
      template.milestones.each do |m|
        project.milestones.create(
          

          name: m["name"],
          lead_time: m["leadTime"],
          complete: false,
          due_date: project.due_date - m["leadTime"].to_i
        )
      end 
      
      project.kind = template.name
      project.save
    end
  end