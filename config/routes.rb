Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "dashboard#index"

  resources :projects, only: %i[new create]
  namespace :admin do
    resources :pending_projects, only: [:index] do
      resources :project_approvals, only: %i[new create]
    end

    resources :moderator_actions, only: [:index]
  end
end
