Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  namespace :api do
    namespace :v1 do
      get "recipes", to: "search#recipes"
      get "learning_resources", to: "search#learning_resources"
      get "tourist_sites", to: "search#tourist_sites"
      resources :users, only: [:create]
      post "sessions", to: "users#login"
    end
  end
end
