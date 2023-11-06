Rails.application.routes.draw do
  devise_for :users
  root to: 'weightlosses#index'
  resources :weightlosses do
    resources :comments, only: :create
  end
  resources :users
  get 'my_posts', to: 'weightlosses#my_posts', as: 'my_posts'
end
