Rails.application.routes.draw do
  get "/dashboard" => "dashboard#index"
  get "/messages"  => "messages#index"
  get "/users"     => "users#index"

  scope constraints: { format: :json }, defaults: { format: :json } do
    namespace :api do
      resources :users, except: [:new, :edit], param: :username do
        collection do
          get "search/:term", action: :search, as: :search
        end

        member do
          put :name,     action: :update_name,     as: :update_name
          put :password, action: :update_password, as: :update_password
          put :enabled,  action: :update_enabled,  as: :update_enabled
          put :email,    action: :update_email,    as: :update_email
          put :dob,      action: :update_dob,      as: :update_dob
        end
      end
    end
  end

  get "/",      to: redirect("/dashboard")
  get "/admin", to: redirect("/dashboard")
  root "dashboard#index"
end
