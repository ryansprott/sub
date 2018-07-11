Rails.application.routes.draw do
  root to: 'home#index'
  get '/stop_info/:id' => 'api#stop_info'
  get '/all_stops' => 'api#all_stops'
  match "/*path", to: redirect("/?redirect=%{path}"), via: :all
end
