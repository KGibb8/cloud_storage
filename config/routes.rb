require "#{Rails.root}/app/lib/domain_generator/subdomain_matcher"

Rails.application.routes.draw do

  devise_for :users

  constraints DomainGenerator::SubdomainPresent do
    root to: 'accounts#show'
    resources :accounts, only: [:update, :destroy]
    resources :directories, only: [:index, :create, :update, :destroy]
    resources :records, only: [:create, :update, :destroy]
  end

  constraints DomainGenerator::SubdomainAbsent do
    root to: 'accounts#index'
    resources :accounts, only: [:index, :create]
  end

end
