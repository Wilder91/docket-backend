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
    
    def update
      # Get the template by its ID
      template = Template.find(params[:id])
    
      # Extract the name and milestones from the request parameters
      name = params[:name]
      milestones = params[:milestones]
    
      # Update the template with the new data
      template.update(name: name, milestones: milestones)
    
      # Respond with a success status and the updated template
      render json: template
    end

    def destroy
        
        template = Template.find_by(id: params[:id])    
        template.destroy

    end
end
