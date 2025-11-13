Rails.application.routes.draw do
  get 'users/new'
  get 'users/create'
  get 'users/show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  # User signup alias
  get "/signup", to: "users#new", as: "signup"

  # Users resources
  resources :users, only: [:new, :create, :show]

  # Root goes to signup page
  root "users#new"
end
