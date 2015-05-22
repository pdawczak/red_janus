Rails.application.routes.draw do
  namespace :api do
    resources :users
  end
  root "home#index"
end
