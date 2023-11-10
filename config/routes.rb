Rails.application.routes.draw do

  resources :milestones, only: [:show, :index]
  resources :projects, only: [:index, :show]
  resources :users, param: :id
  # Authentication
post '/auth/login' => 'authentication#login'
get '/home' => 'authentication#login'

# Users
post '/users' => 'users#create'
get '/users' => 'users#index'
get 'users/:email' => 'users#show'
patch '/users/:id' => 'users#update'
delete '/users/delete/:id' => 'users#delete'

# User Projects
get 'users/:id/projects' => 'projects#user_projects'
post '/users/:id/projects' => 'projects#create'
patch '/projects/:id/complete' => 'projects#toggle_complete'
delete '/projects/:id' => 'projects#delete'
patch '/projects/:id' => 'projects#update'
get '/projects/:id/milestones' => 'milestones#project_index'

# User Templates
get 'users/:id/templates' => 'templates#user_index'
post '/users/:id/templates' => 'templates#create'
delete '/templates/:id' => 'templates#delete'
put '/templates/:id' => 'templates#update'

# User Milestones
get '/users/:id/milestones' => 'milestones#user_index'
patch '/milestones/:id/complete' => 'milestones#toggle_complete'
patch '/milestones/:id' => 'milestones#update'
post '/milestones' => 'milestones#create'
delete '/milestones/:id' => 'milestones#delete'
post '/milestones/:id/notes' => 'milestones#create_or_update_note'
patch '/milestones/:id/notes' => 'milestones#create_or_update_note'



# Catch-All Not Found Route
get '/*a' => 'application#not_found'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
