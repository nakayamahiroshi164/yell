Rails.application.routes.draw do
  devise_for :users
  root to: 'weightlosses#index'
  resources :weightlosses do
    resources :comments, only: :create
  end
  resources :users, only: :show
end
