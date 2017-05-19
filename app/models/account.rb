class Account < ApplicationRecord
  after_create :create_tenant
  after_destroy :remove_tenant

  validates_presence_of :subdomain, :email
  validates_uniqueness_of :subdomain, :email

  private

  def create_tenant
    Apartment::Tenant.create(subdomain)
  end

  def switch_tenant
    Apartment::Tenant.switch!(subdomain)
  end

  def remove_tenant
    Apartment::Tenant.drop(subdomain)
  end
end
