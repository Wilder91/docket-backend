Rails.application.routes.draw do
  resources :templates
  resources :milestones, only: [:show, :index]
  resources :projects, only: [:index, :show]
  resources :users, only: [:index, :show]

  post '/users/:id/projects' => 'projects#create'
  post '/users' => 'users#create'
  get '/home' => 'users#login'
 

  get '/users/:id/milestones' => 'milestones#user_index'
  get 'users/:id/projects' => 'projects#user_projects'
  delete '/milestones/:id' => 'milestones#delete'
  delete '/projects/:id' => 'projects#delete'
  patch 'projects/:id' => 'projects#update'
  get '/projects/:id/milestones' => 'milestones#project_index'
  post 'users/:id/projects/:id/milestones' => 'milestones#create'
  
  post  '/milestones' => 'milestones#create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
