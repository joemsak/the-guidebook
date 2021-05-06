Rails.application.routes.draw do

  resources :sessions, only: [:new, :create, :destroy]

  get :signin, to: 'sessions#new', as: :signin
  get :login, to: 'sessions#new', as: :login

  match :signout, via: %i[get delete], to: 'sessions#destroy', as: :signout
  match :logout, via: %i[get delete], to: 'sessions#destroy', as: :logout

  resources :coaches

  namespace :coach do
    resources :registrations, only: [:new, :create]
    get :signup, to: 'registrations#new', as: :signup
  end

  root to: "coaches#index"
end
