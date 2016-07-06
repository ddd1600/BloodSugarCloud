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
  get "upload_csv", to: "bg_measurements#upload_csv", as: "upload_csv"
  get "scatter", to: "bg_measurements#scatter", as: "scatter"
  post "import_csv", to: "bg_measurements#import_csv", as: "import_csv"
  get "export", to: "bg_measurements#export", as: "export"
  get "about", :to => "bg_measurements#about", as: "about"

end
