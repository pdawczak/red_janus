Rails.application.routes.draw do
  scope constraints: { format: :json }, defaults: { format: :json } do
    namespace :api do
      resources :users, except: [:new, :edit], param: :username do
        collection do
          get "search/:term", action: :search, as: :search
        end

        member do
          put :name, action: :update_name, as: :update_name
        end
      end
    end
  end
  root "home#index"
end
