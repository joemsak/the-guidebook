Rails.application.routes.draw do
  namespace :client do
    resource :dashboard, only: :show
    resources :coaches, only: :show
    get :signup, to: '/public/client_registrations#new', as: :signup
  end
end
