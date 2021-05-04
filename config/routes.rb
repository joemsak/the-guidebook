Rails.application.routes.draw do
  resources :coaches
  root to: "coaches#index"
end
