Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :items do
    resources :item_amounts, only: [ :new, :create, :edit, :update ]

    collection do
      get :expiring_soon
      get :expired
    end
  end
  resources :item_amounts, only: [ :destroy ]
  resources :users, only: [:show]
  root to: 'items#home'
end
