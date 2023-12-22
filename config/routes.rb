Rails.application.routes.draw do
  devise_for :users
  get '/users', to: 'users#index'
  root 'users#index'
 
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [:new, :create, :destroy]
    end
  end
end