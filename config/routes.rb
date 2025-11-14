Rails.application.routes.draw do
  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # User signup alias
  get "/signup", to: "users#new", as: "signup"

  # Users resources
  resources :users, only: [:new, :create, :show]

  # Recipients resources
  resources :recipients, only: [:index, :new, :create, :show]

  # Root goes to signup page
  root "users#new"
end
