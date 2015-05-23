Rails.application.routes.draw do
  scope constraints: { format: :json }, defaults: { format: :json } do
    namespace :api do
      resources :users, except: [:new, :edit]
    end
  end
  root "home#index"
end
