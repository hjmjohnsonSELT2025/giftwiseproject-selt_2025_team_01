Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root "recipients#index"  # default page is the recipients list when user is logged in

  # recipients stuff
  resources :recipients, only: [:index, :new, :create, :edit, :update, :destroy, :show] do
    resources :gift_ideas, only: [:new, :create, :destroy, :edit, :update] do
      collection do
        get :suggest
      end
    end
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
      resources :gift_ideas, controller: "event_recipient_gift_ideas" do
        collection do
          get :suggest
        end
      end
    end
  end
end
