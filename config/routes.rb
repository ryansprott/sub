Rails.application.routes.draw do
  root to: 'home#index'
  namespace :api do
    resources :subway_stops, only: [:index, :show]
    resources :bus_stops, only: [:index, :show]
  end

  get '/service_status' => 'api#service_status'
  get '/equipment_status' => 'api#equipment_status'
  get '/all_equipment' => 'api#all_equipment'
  match "/*path", to: redirect("/?redirect=%{path}"), via: :all
end
