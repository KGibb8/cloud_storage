require "#{Rails.root}/app/lib/subdomain_matcher"

Rails.application.routes.draw do

  devise_for :users

  constraints SubdomainPresent do
    root to: 'accounts#show'
    resources :accounts, only: [:update, :destroy]
    resources :directories, only: [:create, :update, :destroy]
    resources :records, only: [:create, :update, :destroy]
  end

  constraints SubdomainAbsent do
    root to: 'accounts#index'
    resources :accounts, only: [:index, :create]
  end

end
