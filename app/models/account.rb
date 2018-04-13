class Account < ApplicationRecord
  include ApartmentHelper

  has_many :account_users, dependent: :destroy
  has_many :users, through: :account_users

  belongs_to :owner, class_name: 'User', foreign_key: :owner_id

  after_create :create_tenant, :create_root_directory
  after_update :rename_schema, if: :subdomain_changed?
  after_destroy :remove_tenant

  validate :subdomain_format
  validate :excluded_subdomain
  validates_presence_of :subdomain, :email
  validates_uniqueness_of :subdomain, :email, :owner_id

  # #################
  # # Class Methods #
  # #################

  class << self
    def create_with_new_user(account_params, user_params)
      ActiveRecord::Base.transaction do
        Account.new(account_params).tap do |account|
          user = User.new(user_params)
          if user.save && account.save
            account.account_users.create user: user
          else
            raise ActiveRecord::Rollback, "account errors: #{account.errors}, user errors: #{user.errors}"
          end
        end
      end
    end

    def create_with_current_user(account_params, user_id)
      ActiveRecord::Base.transaction do
        Account.new(account_params).tap do |account|
          if account.save
            account.account_users.create user_id: user_id
          else
            raise ActiveRecord::Rollback, account.errors
          end
        end
      end
    end
  end

  private

  def create_tenant
    Apartment::Tenant.create(subdomain)
  end

  def rename_schema
    ActiveRecord::Base.connection.exec_query("ALTER SCHEMA #{subdomain_was} RENAME TO #{subdomain}")
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
