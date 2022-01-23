Rails.application.routes.draw do
  post "/signin", to: "login#create"
  post "/signup", to: "users#create"
  
  namespace :admin do
    post "/signup", to: "users#create"
    resources :users, only: [:create, :index, :update, :edit]
    resources :stores, only: [:create, :index, :update, :edit]
    resources :categories, only: [:create, :index, :update, :edit]
    resources :products, only: [:create, :index, :update, :edit]
  end

  namespace :owner do
    resources :users, only: [:index, :create, :update, :edit]
    resources :stores, only: [:update, :edit]
    resources :categories, only: [:create, :index, :update, :edit]
    resources :products, only: [:create, :index, :update, :edit]
  end

  namespace :seller do
    resources :users, only: [:update, :edit]
    resources :stores, only: [:index]
    resources :categories, only: [:index]
    resources :products, only: [:index, :edit]
  end

  namespace :customer do
    resources :users, only: [:update, :edit]
    resources :products, only: [:index, :edit]
  end

  resources :categories, only: [:index]
  resources :products, only: [:index]

end
