Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :items do
    resources :item_amounts, only: [:new, :create]

    collection do
      get :expiring_soon
    end
  end
  resources :item_amounts, only: [ :destroy ]
  root to: 'items#home'
end
