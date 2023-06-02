class TemplatesController < ApplicationController

    def index 
        templates = Template.all 
        render json: templates
    end

    def create
       template_params = {
        name: params[:name],
        user_id: params[:id],
        milestones: []
      }
    
      params[:milestones].each do |milestone|
        template_params[:milestones] << {
          name: milestone[:name],
          leadTime: milestone[:leadTime],
          complete: false
          
        }
      end
    
      template = Template.new(template_params)
    
      if template.save
        render json: template
      else 
        render json: { errors: template.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
        
        template = Template.find_by(id: params[:id])    
        template.destroy

    end
end
