Rails.application.routes.draw do
  resources :templates
  resources :milestones, only: [:show, :index]
  resources :projects, only: [:index, :show]
  resources :users, param: :id
  post '/auth/login' => 'authentication#login'
  get '/*a' => 'application#not_found'
  get 'users/:email' => 'users#show'
  get 'users/:id/projects' => 'projects#user_projects'

  post '/users/:id/projects' => 'projects#create'
  get 'users/:id/templates' => 'templates#user_index'
  patch '/projects/:id/complete' => 'projects#toggle_complete'
  delete '/templates/:id' => 'templates#delete'
  delete '/projects/:id' => 'projects#delete'
  patch '/projects/:id' => 'projects#update'
  patch '/milestones/:id/complete' => 'milestones#toggle_complete'
  patch '/milestones/:id' => 'milestones#update'
  post '/users/:id/templates' => 'templates#create'
  post '/users' => 'users#create'
  get '/home' => 'authentication#login'
 
  get '/users' => 'users#index'

  
  get '/users/:id/milestones' => 'milestones#user_index'
 
  delete '/milestones/:id' => 'milestones#delete'
  
  get '/projects/:id/milestones' => 'milestones#project_index'
  post 'users/:id/projects/:id/milestones' => 'milestones#create'
  
  post  '/milestones' => 'milestones#create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
