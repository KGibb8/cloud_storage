class AccountUser < ApplicationRecord
  belongs_to :user
  belongs_to :account

  validates_presence_of :user, :account
  validates :account, uniqueness: { scope: [:user_id], message: "User already has access to account" }
end
