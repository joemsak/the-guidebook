require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq", constraints: AdminConstraint.new(&:present?)

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  draw(:public)
  draw(:user)
  draw(:admin)
  draw(:coach)
  draw(:client)

  get :signin, to: 'public/sessions#new', as: :signin
  get :login, to: 'public/sessions#new', as: :login

  match :signout, via: %i[get delete], to: 'user/sessions#destroy', as: :signout
  match :logout, via: %i[get delete], to: 'user/sessions#destroy', as: :logout

  match '/auth/:provider/callback', to: 'user/omniauth#create', via: %i[get post]

  root to: "public/welcome#show"
end
