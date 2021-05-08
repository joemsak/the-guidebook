require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq", constraints: AdminConstraint.new(&:present?)

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  namespace :user do
    resource :dashboard, only: :show
  end

  resources :sessions, only: [:new, :create, :destroy]

  get :signin, to: 'sessions#new', as: :signin
  get :login, to: 'sessions#new', as: :login

  match :signout, via: %i[get delete], to: 'sessions#destroy', as: :signout
  match :logout, via: %i[get delete], to: 'sessions#destroy', as: :logout

  namespace :admin do
    resource :dashboard, only: :show
    resources :coaches
  end

  namespace :coach do
    resources :client_invitations
    resource :dashboard, only: :show
    resources :registrations, only: [:new, :create]
    get :signup, to: 'registrations#new', as: :signup
  end

  root to: "user/dashboards#show"
end
