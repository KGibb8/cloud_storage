require 'rails_helper'

describe Account do
  let(:account) { create :account }

  let(:invalid_account) do
    ->(params) { Account.create params }
  end

  describe '#create' do
    it 'is invalid without a subdomain' do
      expect(invalid_account[ email: Faker::Internet.email ]).to_not be_valid
    end

    it 'is invalid without an email address' do
      expect(invalid_account[ subdomain: Faker::StarWars.planet ]).to_not be_valid
    end

    it 'is valid with email and subdomain' do
      expect(account).to be_valid
    end
  end
end
