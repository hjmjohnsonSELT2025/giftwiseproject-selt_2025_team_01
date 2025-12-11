Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # User signup alias
  get "/signup", to: "users#new", as: "signup"
  resources :users, only: [:new, :create]
  root "recipients#index"  # default page is the recipients list when user is logged in

  # login/logout stuff
  get "/login",  to: "sessions#new",     as: "login"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: "logout"

  #Password reset stuff:
  resources :password_resets, only: [:new, :create, :edit, :update]


  # recipients stuff
  resources :recipients, only: [:index, :new, :create, :edit, :update, :destroy, :show] do
    resources :gift_ideas, only: [:new, :create, :destroy, :edit, :update]
  end
  resources :profiles, only: [:show, :edit, :update]

  # events stuff
  resources :events do
    member do
      post 'add_recipient'
      delete 'remove_recipient'
    end

    # event-specific gifts
    resources :recipients, only: [] do
      resources :gift_ideas, controller: "event_recipient_gift_ideas"
    end
  end
end
