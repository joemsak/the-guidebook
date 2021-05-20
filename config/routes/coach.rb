Rails.application.routes.draw do
  namespace :coach do
    resource :dashboard, only: :show

    resources :client_profiles, only: [:index, :show],
      as: :clients,
      controller: :clients,
      path: :clients

    resources :client_invitations

    resources :coaching_sessions

    get :signup, to: '/public/coach_registrations#new', as: :signup
  end
end
