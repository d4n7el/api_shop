Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'

  post "/signin", to: "login#create"

  namespace :admin do
    post "/signup", to: "users#create"
    resources :users, only: [:index, :update, :edit]
    resources :stores, only: [:create, :index, :update, :edit]
  end

  namespace :owner do
    resources :users, only: [:index, :create, :update, :edit]
    resources :stores, only: [:update, :edit]
  end

  namespace :seller do
    resources :users, only: [:update, :edit]
    resources :stores, only: [:edit]
  end

end
