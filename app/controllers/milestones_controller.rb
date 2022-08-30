class MilestonesController < ApplicationController
    def show 
        milestone = Milestone.find_by(id: params[:id])
        if milestone 
            render json: milestone
        else 
            render json: "Nope!"
        end 
    end

    def index 
        milestones = Milestone.all 
        render json: milestones
    end

    def create 
        milestone = Milestone.new 
        milestone.name = params[:name]
        milestone.description = params[:description]
        milestone.project_id = params[:project_id]
        milestone.due_date = milestone.project.due_date - params[:lead_time].to_i
        milestone.save
        render json: milestone
    end

    def project_index 
        milestones = Milestone.where(project_id: params[:id])

        render json: milestones
    end

    def delete 
        #binding.pry
        milestone = Milestone.find_by(id: params[:id])
        milestone.destroy

    end
end
