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

        milestones = Milestone.all.sort { |a,b| a.due_date <=> b.due_date } 
        render json: milestones
    end

    def create
        #binding.pry 
        milestone = Milestone.new 
        milestone.name = params[:name]
        milestone.description = params[:description]
        milestone.project_id = params[:project_id]
        milestone.due_date = params[:date]
        milestone.save!
        render json: milestone
    end

    def project_index 
        milestones = Milestone.where(project_id: params[:id])
        m = milestones.all.sort { |a,b| a.due_date <=> b.due_date } 
        render json: m
    end

    def delete 
        #binding.pry
        milestone = Milestone.find_by(id: params[:id])
        milestone.destroy

    end
end
