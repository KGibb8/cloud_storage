Rails.application.routes.draw do

  devise_for :users

  constraints DomainGenerator::SubdomainPresent do
    root to: 'directories#index'
    get 'account', to: 'accounts#show', as: :account
    get 'account/settings', to: 'accounts#settings', as: :account_settings
    patch 'account', to: 'accounts#update', as: :update_account
    delete 'account', to: 'accounts#destroy', as: :destroy_account

    resources :directories, only: [:show, :create, :update, :destroy]
    resources :records, only: [:create, :update, :destroy]
  end

  constraints DomainGenerator::SubdomainAbsent do
    root to: 'accounts#index'
    resources :accounts, only: [:create]
    resources :directories, only: [:index]
  end

end
