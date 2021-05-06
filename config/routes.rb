Rails.application.routes.draw do
  namespace :coach do
    resources :registrations, only: [:new, :create]
    get :signup, to: 'registrations#new', as: :signup
  end

  resources :coaches

  root to: "coaches#index"
end
