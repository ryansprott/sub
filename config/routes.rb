Rails.application.routes.draw do
  root to: 'home#index'
  get '/subway_arrivals/:id' => 'api#subway_arrivals'
  get '/all_subway_stops' => 'api#all_subway_stops'
  match "/*path", to: redirect("/?redirect=%{path}"), via: :all
end
