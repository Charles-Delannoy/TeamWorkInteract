Rails.application.routes.draw do
  root to: 'pages#home'

  devise_for :users

  resources :admin_users, only: [:index, :create]

  resource :dashboard, only: :show

  resource :validate_accounts, only: [:edit, :update]

  resources :surveys, only: [:index, :new, :create, :destroy, :edit, :update, :show] do
    resources :questions, only: [:new, :create ]
  end

  resources :questions, only: [ :show, :edit, :update, :destroy ] do
    resources :propositions, only: [:create]
  end

  resources :propositions, only: [ :edit, :update, :destroy ]

  resources :groups, only: [:index, :new, :create, :destroy, :edit, :update]

  resources :axes, only: [:index, :new, :create, :destroy, :edit, :update, :show] do
    resources :recommandations, only: [:new, :create]
  end

  resources :recommandations, only: [:edit, :update, :destroy]

  resources :campaigns, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  resources :group_campaigns, only: [:create, :destroy]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
