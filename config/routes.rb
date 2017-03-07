Rails.application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  resources :cards
  resources :users

  post :signin, to: "sessions#create"
  get :signin, to: "sessions#new"
  post :signout, to: "sessions#destroy"

  get '/check', to: 'home#check'

  root to: 'home#welcome'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
