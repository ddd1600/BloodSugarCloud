Bloodsugar::Application.routes.draw do
#  get "sessions/new"
#  get "sessions/create"
#  get "sessions/destroy"
  resources :users

  resources :bg_measurements
#  root "bg_measurements#index"
  
#  get "sessions/new"
#  get "sessions/create"
#  get "sessions/destroy"

  resources :sessions, only: [:new, :create, :destroy]
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  resources :users
  get 'users/index'
  root 'bg_measurements#index'

end
