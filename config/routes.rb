Rails.application.routes.draw do
  get 'users/new'

  resources :cards
  resources :users, only: [:new, :create]

  get '/check', to: 'home#check'

  root to: 'home#welcome'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
