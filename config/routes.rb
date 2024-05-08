Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", :as => :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  resources :playlists, only: [:index, :create, :show]

  resources :playlist_entries, only: [:create, :destroy] do
    put :move, on: :member
  end

  resources :videos, only: [:index] do
    put :refresh, on: :collection
  end
end
