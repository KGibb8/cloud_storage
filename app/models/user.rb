class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :account_users
  has_many :accounts, through: :account_users
  has_many :owned_accounts, ->(user_id) { where(owner_id: user_id) }, class_name: 'Account'

  has_one :root, -> { where(directory_id: nil) }, class_name: 'Directory'

  has_many :directories
  has_many :records

  after_create :create_root_directory

  def account
    owned_accounts.first
  end

  private

  def create_root_directory
    directories.create(directory_id: nil)
  end

end
