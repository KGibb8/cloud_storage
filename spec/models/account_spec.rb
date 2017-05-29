require 'rails_helper'

describe Account do
  let!(:account) { create :account }

  let(:invalid_account) do
    ->(params) { Account.create params }
  end

  describe '#create' do
    it 'is invalid without a subdomain' do
      expect(invalid_account[ email: Faker::Internet.email ]).to_not be_valid
    end

    it 'is invalid without an email address' do
      expect(invalid_account[ subdomain: 'woof']).to_not be_valid
    end

    it 'is valid with email and subdomain' do
      expect(account).to be_valid
    end
  end

  let(:account_params) { { email: Faker::Internet.email, subdomain: 'woof' } }
  let(:user_params) { { email: Faker::Internet.email, password: 'password', password_confirmation: 'password' } }

  describe '#create_with_new_user' do
    let(:account) { Account.create_with_new_user(account_params, user_params) }

    context 'with valid creation criteria' do
      it 'returns a new account' do
        expect(account).to_not be_nil
        expect(account).to be_a_kind_of Account
      end

      it 'creates a new user' do
        expect(account.users.first).to be_valid
        expect(account.users.count).to be 1
      end

      it 'creates a account_user' do
        expect(account.account_users.first).to be_valid
        expect(account.account_users.count).to be 1
      end
    end

    context 'with invalid creation criteria' do
      let(:invalid) { Account.create_with_new_user({subdomain: 'woof'}, {email: 'smeg'}) }

      it 'returns nil if rollback' do
        expect(invalid).to be_nil
      end
    end
  end

  describe '#create_with_current_user' do
    let(:user) { create :user }
    let(:account) { Account.create_with_current_user(account_params, user.id) }

    context 'with valid creation criteria' do
      it 'returns a new account' do
        expect(account).to_not be_nil
        expect(account).to be_a_kind_of Account
      end

      it 'creates a account_user' do
        expect(account.account_users.first).to be_valid
        expect(account.account_users.count).to be 1
      end
    end

    context 'with invalid creation criteria' do
      let(:invalid) { Account.create_with_current_user({subdomain: 'woof'}, user.id) }

      it 'returns nil if rollback' do
        expect(invalid).to be_nil
      end
    end
  end

  describe 'deleting an account' do
    it 'drops the equivalent schema' do
      account.destroy
      expect(Account.pluck(:subdomain)).to_not include account.subdomain
    end
  end
end
