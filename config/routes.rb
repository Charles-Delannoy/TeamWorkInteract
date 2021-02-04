Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'dashboard', to: 'pages#dashboard'

  resources :surveys, only: [:index, :new, :create, :destroy, :edit, :update, :show] do
    resources :questions, only: [:new, :create]
  end
  
  resources :groups, only: [:index, :new, :create, :destroy, :edit, :update]
  resources :axes, only: [:index, :new, :create, :destroy, :edit, :update, :show]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
