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
        #binding.pry
      project = Project.new(project_params)
      if project.save
        create_from_template(project, params[:template])
        render json: project
      else 
        render json: { errors: project.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def update 
      if @project.update(project_params)
        if @project.template?
          Template.create(name: @project.kind, milestones: @project.milestones, user_id: @project.user.id)
        end
        render json: @project
      else
        render json: { errors: @project.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def delete 
        binding.pry
      @project.destroy
    end
  
    def user_projects 
      user = User.find_by(id: params[:id])
      projects = user.projects.all.sort_by(&:due_date)
      render json: projects, include: :milestones
    end
  
    private 
  
    def project_params 
      params.require(:project).permit(:name, :kind, :due_date, :user_id, :template)
    end
  
    def find_project
      @project = Project.find_by(id: params[:id])
      render json: { errors: 'Project not found' }, status: :not_found unless @project
    end
  
    def create_from_template(project, template_name)
        #binding.pry
      return unless template_name.present?
  
      template = Template.find_by(name: template_name)
      return unless template
  
      template.milestones.each do |m|
        project.milestones.create(
          name: m["name"],
          lead_time: m["lead_time"],
          complete: false,
          due_date: project.due_date - m["leadTime"].to_i
        )
      end 
      project.kind = template.name
      project.save
    end
  end