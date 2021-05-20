Rails.application.routes.draw do
  namespace :user do
    resource :dashboard, only: :show
    resources :sessions, only: :destroy
  end
end
