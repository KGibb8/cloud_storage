Rails.application.routes.draw do

  devise_for :users

  constraints DomainGenerator::SubdomainPresent do
    root to: 'directories#index'
    get 'account', to: 'accounts#show', as: :account

    resources :accounts, only: [:update, :destroy]
    resources :directories, only: [:show, :create, :update, :destroy]
    resources :records, only: [:create, :update, :destroy]
  end

  constraints DomainGenerator::SubdomainAbsent do
    root to: 'accounts#index'
    resources :accounts, only: [:index, :create]
    resources :directories, only: [:index]
  end

end
