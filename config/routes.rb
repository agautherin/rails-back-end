Rails.application.routes.draw do
  resources :chatrooms
  resources :encryptions
  resources :messages
  resources :users
  resources :groups
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
