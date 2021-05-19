require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq", constraints: AdminConstraint.new(&:present?)

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

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

  namespace :user do
    resource :dashboard, only: :show
    resources :sessions, only: :destroy
  end

  namespace :admin do
    resource :dashboard, only: :show
    resources :coaches
  end

  namespace :coach do
    resource :dashboard, only: :show
    resources :client_invitations
    resources :coaching_sessions
    get :signup, to: '/public/coach_registrations#new', as: :signup
  end

  namespace :client do
    resource :dashboard, only: :show
    get :signup, to: '/public/client_registrations#new', as: :signup
  end

  get :signin, to: 'public/sessions#new', as: :signin
  get :login, to: 'public/sessions#new', as: :login

  match :signout, via: %i[get delete], to: 'user/sessions#destroy', as: :signout
  match :logout, via: %i[get delete], to: 'user/sessions#destroy', as: :logout

  match '/auth/:provider/callback', to: 'user/omniauth#create', via: %i[get post]

  root to: "public/welcome#show"
end
