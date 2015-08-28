Rails.application.routes.draw do
  resources :aktions
  resources :role_assignments
  resources :project_memberships
  resources :team_memberships
  resources :locations, :verbs
  resources :players do
    resources :aktions
  end
  resources :teams do
    member { get :join, :leave, :activate }
    resources :projects
    resources :roles
    resources :aktions, path: "actions"
  end

  resources :roles, only: :destroy
  resources :projects, only: :destroy

  root to: 'visitors#index'
  get '/help' => 'visitors#help'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'
end
