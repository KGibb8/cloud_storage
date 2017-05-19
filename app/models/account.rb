class Account < ApplicationRecord

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
    def create_with_admin_user(params)
      Account.create(params[:account]).tap do |account|
        account.switch_tenant!
        User.create(params[:user].merge(admin: true))
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
