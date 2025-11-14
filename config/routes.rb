Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # User signup alias
  get "/signup", to: "users#new", as: "signup"
  resources :users, only: [:new, :create, :show]
  root "users#new"  # the default landing page will be the signup page

  # login/logout stuff
  get "/login",  to: "sessions#new",     as: "login"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: "logout"

  # recipients stuff
  resources :recipients, only: [:index, :new, :create, :edit, :update, :destroy]
end
