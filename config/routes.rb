require "#{Rails.root}/app/lib/domain_generator/subdomain_matcher"

Rails.application.routes.draw do

  devise_for :users

  constraints DomainGenerator::SubdomainPresent do
    root to: 'directories#index'
    resources :accounts, only: [:show, :update, :destroy]
    resources :directories, only: [:create, :update, :destroy]
    resources :records, only: [:create, :update, :destroy]
  end

  constraints DomainGenerator::SubdomainAbsent do
    root to: 'accounts#index'
    resources :accounts, only: [:index, :create]
    resources :directories, only: [:index]
  end

end
