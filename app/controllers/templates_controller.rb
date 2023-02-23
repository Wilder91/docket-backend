class TemplatesController < ApplicationController

    def index 
        templates = Template.all 
        render json: templates

    end

    def destroy
        #binding.pry
        template = Template.find_by(id: params[:id])    
        template.destroy

    end
end
