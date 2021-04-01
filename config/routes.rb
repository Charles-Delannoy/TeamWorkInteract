Rails.application.routes.draw do
  # get 'answers/create'
  # get 'answers/update'
  root to: 'pages#home'

  devise_for :users

  # DASHBOARDS
  resource :dashboard, only: :show
  namespace :admin do
    resource :dashboard, only: :show
  end

  # ACCOUNT VALIDATION FOR INVITED USERS
  resource :validate_accounts, only: [:edit, :update]

  # ACCESS GROUPS
  resource :access_groups, only: [:update]

  # ADMIN ONLY
  resources :recommandations, only: [:edit, :update, :destroy]

  resources :campaigns, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  resources :group_campaigns, only: [:create, :destroy]

  resources :axes, only: [:index, :new, :create, :destroy, :edit, :update, :show] do
    resources :recommandations, only: [:new, :create]
  end

  resources :admin_users, only: [:index, :create]

  resources :chatrooms, only: [:new, :show] do
    resources :messages, only: [:create]
  end
  # GLOBAL ROUTES

  resources :surveys, only: [:index, :new, :create, :destroy, :edit, :update, :show] do
    resources :questions, only: [:new, :create ]
  end

  resources :questions, only: [ :edit, :update, :destroy ] do
    resources :propositions, only: [:create]
  end

  resources :propositions, only: [ :edit, :update, :destroy ]

  resources :answers, only: [:create, :update]

  resources :groups, only: [:index, :create, :destroy, :edit, :update]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
