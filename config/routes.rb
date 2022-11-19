Rails.application.routes.draw do
  resources :templates
  resources :milestones, only: [:show, :index]
  resources :projects, only: [:index, :show]
  resources :users, only: [:index, :show]

  
  post '/users' => 'users#create'
  get '/user' => 'users#login2'
 
  get 'users/:id/milestones' => 'milestones#user_milestones'
  get 'users/:id/projects' => 'projects#user_projects'
  post '/users/:id/projects' => 'projects#create'
  delete '/milestones/:id' => 'milestones#delete'
  delete '/projects/:id' => 'projects#delete'
  patch 'projects/:id' => 'projects#update'
  get '/projects/:id/milestones' => 'milestones#project_index'
  post '/projects/:id/milestones' => 'milestones#create'
  
  post  '/milestones' => 'milestones#create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
