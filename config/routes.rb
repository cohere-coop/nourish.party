Rails.application.routes.draw do
  use_doorkeeper
  devise_for :registered_users, path: :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "dashboard#index"

  resources :projects, only: %i[new create] do
    resources :approvals, only: %i[new create], controller: "project_rejections"
    resources :rejections, only: %i[new create], controller: "project_approvals"
  end
  resources :my_projects, only: %i[index]

  resources :pending_projects, only: [:index]

  resources :project_status_changes, only: [:index]

  resources :stripe_connections, only: [:destroy]

  get "/auth/stripe_connect/callback", to: "stripe_connections#create"
end
