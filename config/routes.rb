Rails.application.routes.draw do
  root to: "home#index"
  namespace :api do
    resources :subway_stops, only: [:index, :show]
    resources :bus_stops, only: [:index, :show]
  end

  match "/*path", to: redirect("/?redirect=%{path}"), via: :all
end
