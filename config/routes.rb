Rails.application.routes.draw do

  devise_for :users
  root to: 'accounts#index'
  resources :accounts, only: [:index, :create]

end
