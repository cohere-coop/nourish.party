Rails.application.routes.draw do
  devise_for :registered_users, path: :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "dashboard#index"

  resources :projects, only: %i[new create]
  resources :my_projects, only: %i[index]

  resources :pending_projects, only: [:index] do
    resources :project_approvals, only: %i[new create]
    resources :project_rejections, only: %i[new create]
  end

  resources :project_status_changes, only: [:index]
end
