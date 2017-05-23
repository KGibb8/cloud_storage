class Account < ApplicationRecord

  has_many :account_users
  has_many :users, through: :account_users

  after_create :create_tenant
  after_destroy :remove_tenant

  validates_presence_of :subdomain, :email
  validates_uniqueness_of :subdomain, :email

  def switch_tenant!
    Apartment::Tenant.switch!(subdomain)
  end

  # #################
  # # Class Methods #
  # #################

  class << self
    def create_with_user(params)
      # %%TODO%% We want to rollback the Account if the User fails to build
      Account.create(params[:account]).tap do |account|
        return unless account
        User.create(params[:user]).tap do |user|
          return unless user
          account.account_users.create user: user
        end
      end
    end
  end

  private

  def create_tenant
    Apartment::Tenant.create(subdomain)
  end

  def remove_tenant
    Apartment::Tenant.drop(subdomain)
  end
end
