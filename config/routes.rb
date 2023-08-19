Rails.application.routes.draw do
  devise_for :users
  root 'homes#index'
  post 'books' => 'books#create'
  get '/about', to: 'homes#about', as: 'about'
  resources :users, only: [:index, :edit, :update, :show]
  resources :books, only: [:edit, :create, :index, :show, :update, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
