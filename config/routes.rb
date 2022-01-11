Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'

  post "/signin", to: "login#create"
  post "/signup", to: "users#create"

  resources :users, only: [:index, :destroy, :update, :edit]

  namespace :admin do
    resources :stores, only: [:index, :update, :edit]
  end

  namespace :owner do
    resources :stores, only: [:update, :edit]
  end

  namespace :seller do
    resources :stores, only: [:edit]
  end

end
