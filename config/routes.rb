Rails.application.routes.draw do
  root to: 'home#index'
  namespace :api do
    resources :foo
  end
  match "/*path", to: redirect("/?redirect=%{path}"), via: :all
end
