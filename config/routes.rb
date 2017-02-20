Rails.application.routes.draw do
  get 'cards/index'

  get 'cards/new'

  get 'cards/show'

  root to: 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
