Rails.application.routes.draw do
  resources :projects
  resources :locations
  resources :teams
  resources :roles
  resources :verbs
  resources :aktions
  resources :aktions, path: "actions"
  resources :players
  resources :users
  root to: 'visitors#index'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'
end
