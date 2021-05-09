require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq", constraints: AdminConstraint.new(&:present?)

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  namespace :public do
    resources :coach_registrations, only: [:new, :create]
    resources :sessions, only: [:new, :create, :destroy]

    resources :client_invitations, only: :show do
      member do
        get :accept
      end
    end
  end

  namespace :user do
    resource :dashboard, only: :show
  end

  namespace :admin do
    resource :dashboard, only: :show
    resources :coaches
  end

  namespace :coach do
    resources :client_invitations
    resource :dashboard, only: :show
    get :signup, to: '/public/coach_registrations#new', as: :signup
  end


  get :signin, to: 'public/sessions#new', as: :signin
  get :login, to: 'public/sessions#new', as: :login

  match :signout, via: %i[get delete], to: 'public/sessions#destroy', as: :signout
  match :logout, via: %i[get delete], to: 'public/sessions#destroy', as: :logout

  root to: "user/dashboards#show"
end
