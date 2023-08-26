Rails.application.routes.draw do
  root 'homes#index'
  
  
  devise_for :users
  post 'books' => 'books#create'
  get '/about', to: 'homes#about', as: 'about'
  resources :users, only: [:index, :edit, :update, :show]
  resources :books, only: [:edit, :create, :index, :show, :update, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
