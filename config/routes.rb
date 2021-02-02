Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'dashboard', to: 'pages#dashboard'

  resources :groups, only: [:index, :new, :create, :destroy, :edit, :update]
  resources :surveys, only: [:index, :new, :create, :destroy, :edit, :update]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
