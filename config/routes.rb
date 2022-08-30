Rails.application.routes.draw do
  resources :templates
  resources :milestones, only: [:show, :index]
  resources :projects, only: [:index, :show]
  resources :users, only: [:index, :show]

  post '/projects' => 'projects#create'
  post '/users' => 'users#create'
  
  get 'users/:id/milestones' => 'milestones#user_milestones'
  get 'users/:id/projects' => 'projects#user_projects'
  delete 'projects/:id/milestones/:id' => 'milestones#delete'
  delete '/projects/:id' => 'projects#delete'
  patch 'projects/:id' => 'projects#update'
  get 'projects/:id/milestones' => 'milestones#project_index'
  post  '/projects/:id/milestones' => 'milestones#create'
 
end
