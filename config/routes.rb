Rails.application.routes.draw do
  devise_for :users
  resources :admin_users, only: [:index, :create]
  root to: 'pages#home'
  get 'dashboard', to: 'pages#dashboard'
  get 'validation', to: 'pages#validate_account_edit'
  patch 'validation', to: 'pages#validate_account'

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

  resources :campaigns, only: [:index, :new, :create, :edit, :update, :destroy]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
