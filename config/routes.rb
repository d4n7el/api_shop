Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  post "/signin", to: "login#create"
  post "/signup", to: "users#create"

  resources :users, only: [:index, :destroy, :update, :edit]
 
end
