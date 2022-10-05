Rails.application.routes.draw do
  devise_for :customer_users, controllers: { sessions: "customer_users/sessions", registrations: 'customer_users/registrations' }
  devise_for :users, controllers: { sessions: "users/sessions", registrations: 'users/registrations'}

  devise_scope :user do
    authenticated :user do

    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "welcome#index"

  namespace :client do
    root to: "media#index"
    resources :customer_users
    resources :rooms, only: [:show]
    resources :reservations
  end

  namespace :employee do
    root to: "dashbord#index"

    resources :roles do
      member do
        delete "delete_role_user", to: "roles#destore_role_user"
      end
      resources :permissions
    end

    resources :hotels do
      resources :buildings, shallow: true do
        resources :rooms, shallow: true
      end
    end

    resources :users
  end
end
