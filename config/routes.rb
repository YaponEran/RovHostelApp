Rails.application.routes.draw do
  devise_for :admin_users, controllers: { sessions: "admin_users/sessions", registrations: "admin_users/registrations" }
  devise_for :customer_users, controllers: { sessions: "customer_users/sessions", registrations: 'customer_users/registrations' }
  devise_for :users, controllers: { sessions: "users/sessions", registrations: 'users/registrations'}

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "welcome#index"

  namespace :api do
    namespace :react do
      namespace :v1 do
        resources :rooms, only: [:index]
      end
    end
  end

  namespace :admin do
    root to: "dashboard#index"
    resources :admin_users
    
    resources :individuals do
      # resources :users, shallow: true, only: [:create, :update]
      member do
        get "new_individual_user", to: "individuals#new_individual_user"
        post "create_individual_user", to: "individuals#create_individual_user"
      end
    end
  end

  namespace :client do
    root to: "media#index"
    resources :customer_users
    resources :rooms, only: [:show] do
      member do
        post :customer_user_reservation, to: "rooms#customer_room_reservation"
      end
    end
    resources :reservations

    resources :hotels do
      resources :buildings, shallow: true do
        resources :rooms, shallow: true
      end
    end
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

        member do
          get "room_reserves", to: "buildings#reserves"
        end
      end
    end

    resources :users
  end
end
