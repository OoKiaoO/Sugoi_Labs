Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :items do
    resources :item_amounts, only: :create
  end
  resources :item_amounts, only: [ :destroy ]
  root to: 'items#home'
end
