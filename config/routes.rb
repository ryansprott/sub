Rails.application.routes.draw do
  root to: 'home#index'
  get '/stop_info/:id' => 'api#stop_info', as: 'stop_info'
  match "/*path", to: redirect("/?redirect=%{path}"), via: :all
end
