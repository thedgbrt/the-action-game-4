Rails.application.routes.draw do
  resources :aktions
  resources :role_assignments
  resources :project_memberships
  resources :team_memberships
  resources :locations, :verbs, :players
  resources :teams do
    member { get :join, :leave, :activate }
    resources :projects
    resources :roles
    resources :aktions, path: "actions"
  end

  #temporary
  resources :roles
  resources :projects

  root to: 'visitors#index'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'
end
