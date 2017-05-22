class SubdomainPresent
  def self.matches?(request)
    request.subdomain.present?
  end
end

class SubdomainAbsent
  def self.matches?(request)
    request.subdomain.blank?
  end
end

Rails.application.routes.draw do

  devise_for :users

  constraints SubdomainPresent do
    root to: 'accounts#show'
  end

  constraints SubdomainAbsent do
    root to: 'accounts#index'
    resources :accounts, only: [:index, :create]
  end

end
