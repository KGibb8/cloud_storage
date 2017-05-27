class Account < ApplicationRecord
  include ApartmentHelper

  has_many :account_users, dependent: :destroy
  has_many :users, through: :account_users

  after_create :create_tenant, :create_root_directory
  after_destroy :remove_tenant

  validate :subdomain_format
  validate :excluded_subdomain
  validates_presence_of :subdomain, :email
  validates_uniqueness_of :subdomain, :email

  # #################
  # # Class Methods #
  # #################

  class << self
    def create_with_user(params)
      ActiveRecord::Base.transaction do
        account = Account.new(params[:account])
        user = User.new(params[:user])
        if user.save && account.save
          account.account_users.create user: user
        else
          raise ActiveRecord::Rollback, "AccountErrors: #{account.errors}, UserErrors: #{user.errors}"
        end
        { account: account, user: user }
      end
    end
  end

  private

  def create_tenant
    Apartment::Tenant.create(subdomain)
  end

  def create_root_directory
    switch_tenant!(subdomain)
    Directory.create
    switch_tenant!
  end

  def remove_tenant
    Apartment::Tenant.drop(subdomain)
  end

  def excluded_subdomain
    errors.add(:excluded_subdomain, 'subdomain reserved or in use') if Apartment::Elevators::Subdomain.excluded_subdomains.include? subdomain
  end

  def subdomain_format
    errors.add(:subdomain_format, 'invalid subdomain format') if subdomain !~ /\A[a-zA-Z][a-zA-Z0-9\-]*[a-zA-Z0-9]\Z/
  end
end
