Rails.application.routes.draw do
  namespace :public do
    resource :welcome, only: :show

    resources :coach_registrations, only: [:new, :create]
    resources :client_registrations, only: [:new, :create]

    resources :sessions, only: [:new, :create]

    resources :client_invitations, only: :show do
      member do
        get :accept
      end
    end
  end
end
