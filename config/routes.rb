Rails.application.routes.draw do

  
  resources :chatrooms, only: [:index, :create, :show]
  resources :encryptions, only: [:index, :create]
  resources :messages, only: [:create]
  resources :users, except: :destroy
  resources :groups
  
  post '/users/login', to: 'users#login'
  post '/users/check', to: 'users#check'

  post 'encryptions/decrypt', to: 'encryptions#decrypt'
  
  
  mount ActionCable.server => '/cable'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
