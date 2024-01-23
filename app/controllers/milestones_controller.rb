class MilestonesController < ApplicationController
  before_action :authorize_request, except: [:create, :index, :delete, :update, :create_or_update_note, :toggle_complete]
    def show 
        milestone = Milestone.find_by(id: params[:id])
        if milestone 
            render json: milestone, include: :project
        else 
            render json: "Nope!"
        end 
    end

    def create
      #binding.pry
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
        render json: milestones, include: :project
        #binding.pry
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
      milestone = Milestone.find_by(id: params[:id])
    
      if milestone
        # Store the milestone attributes before potential changes
        original_attributes = milestone.attributes
        #binding.pry
        # Update the milestone attributes only if the parameters are present and non-empty
        milestone.assign_attributes(
          name: params["name"].presence || milestone.name,
          description: params["description"],
          due_date: params["due_date"].presence || milestone.due_date,
          project_name: params["project_name"],
          google_id: params["google_event_id"].presence || milestone.google_id
        )
    
        # Check if any changes have been made
        if milestone.changed?
          if milestone.save
            render json: milestone
          else
            render json: { message: "Error saving milestone after changes", errors: milestone.errors }, status: :unprocessable_entity
          end
        else
          render json: { message: "No changes detected" }, status: :unprocessable_entity
        end
      else
        render json: { message: "Milestone not found" }, status: :not_found
      end
    end

    def create_or_update_note
        @milestone = Milestone.find(params[:id])
      
        # Adjust the permitted attributes as needed
        note_params = params.permit(:notes)
      
        # Check if a note already exists for this milestone
        if @milestone.notes
          # Update the existing note
          if @milestone.update(note_params)
            render json: { status: 'Note updated successfully', notes: @milestone.notes }
          else
            render json: { errors: @milestone.errors.full_messages }, status: :unprocessable_entity
          end
        else
          # Create a new note for the milestone
          @milestone.notes = params[:notes]
          if @milestone.save
            render json: { status: 'Note added successfully', notes: @milestone.notes }
          else
            render json: { errors: @milestone.errors.full_messages }, status: :unprocessable_entity
          end
        end
      end
      
    def toggle_complete 
        #binding.pry
        milestone = Milestone.find_by(id: params["id"])
        milestone.complete = params["complete"]
        milestone.completion_date = params["completion_date"]
        milestone.save

        render json: milestone
    end

    def delete 
        #binding.pry
        milestone = Milestone.find_by(id: params[:id])
        milestone.delete
    end
end
