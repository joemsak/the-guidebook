Rails.application.routes.draw do
  namespace :admin do
    resource :dashboard, only: :show
    resources :coaches
  end
end
