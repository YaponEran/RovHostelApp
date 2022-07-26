Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions", registrations: 'users/registrations'}


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "welcome#index"

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
