Rails.application.routes.draw do

  
  resources :chatrooms, only: [:index, :create, :show]
  resources :encryptions
  resources :messages, only: [:create]
  resources :users, except: :destroy
  resources :groups
  
  post '/users/login', to: 'users#login'
  
  
  mount ActionCable.server => '/cable'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
