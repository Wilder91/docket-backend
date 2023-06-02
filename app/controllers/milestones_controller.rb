class MilestonesController < ApplicationController
    def show 
        milestone = Milestone.find_by(id: params[:id])
        if milestone 
            render json: milestone, include: :project
        else 
            render json: "Nope!"
        end 
    end

    def create
        milestone = Milestone.new 
        milestone.name = params[:name]
        milestone.description = params[:description]
        milestone.project_id = params[:project_id]
        milestone.due_date = params[:date]
        milestone.project_name = params[:project_name]
        milestone.lead_time = (milestone.project.due_date - milestone.due_date).to_i
        
        milestone.save!
        render json: milestone
    end



    def index 

        milestones = Milestone.all.sort { |a,b| a.due_date <=> b.due_date } 
        render json: milestones
    end

    def user_index 
        user = User.find_by(id: params[:id])
        render json: user.milestones.sort { |a,b| a.due_date <=> b.due_date }
    end

 

    def project_index 
        milestones = Milestone.where(project_id: params[:id])      
        m = milestones.all.sort { |a,b| a.due_date <=> b.due_date } 
        if m.length == 0
            render json: {message: "This Project Doesn't Have any Milestones yet"}
        else
            render json: m, include: :project
        end
    end

    def update 
        #binding.pry
        milestone = Milestone.find_by(id: params[:id])
        milestone.update(name: params["name"], description: params["description"], due_date: params["due_date"], project_name: params["project_name"])
        
        milestone.save
       
        render json: milestone

    end
    def toggle_complete 
        
        milestone = Milestone.find_by(id: params["id"])
        milestone.complete = params["complete"]
        milestone.save
    end

    def delete 
        #binding.pry
        milestone = Milestone.find_by(id: params[:id])
        milestone.delete
    end
end
