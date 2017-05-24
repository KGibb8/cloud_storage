class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :account_users
  has_many :accounts, through: :account_users

  has_one :root, -> { where(directory_id: nil) }, class_name: 'Directory'

  has_many :directories
  has_many :records

end
