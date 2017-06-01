require 'rails_helper'

describe ApplicationController do

  let(:current_account) { create :account }
  let(:current_user) { create :user }
  let(:current_account_user) { current_account.account_users.create user: current_user }

  let(:stub_request) do
    ->(domain) { controller.request.host = "#{domain}.#{ENV.fetch( 'APP_DOMAIN' )}" }
  end

  describe '#current_account' do
    context 'with generic subdomain' do
      it 'sets current_account to nil' do
        stub_request[ 'app' ]
        expect(subject.current_account).to be_nil
      end
    end

    context 'with personal subdomain' do
      it 'assigns current_account' do
        stub_request[ "#{current_account.subdomain}" ]
        expect{ subject.current_account }.to change{ assigns :current_account }
      end
    end

    context 'with invalid subdomain' do
      it 'sets current_account to nil' do
        stub_request[ 'pangalacticgargleblaster' ]
        expect(subject.current_account).to be_nil
      end
    end
  end

  describe '#current_account_user' do
    before do
      request.env['HTTPS'] = 'on'
      subject.instance_variable_set(:@current_user, current_user)
      sign_in current_user
    end

    context '#user_accessing_subdomain?' do
      context 'with account_user authentication' do
        it 'assigns current_account_user' do
          current_account_user
          stub_request[ "#{current_account.subdomain}" ]
          expect{ subject.current_account_user }.to change{ assigns :current_account_user }
        end
      end

      context 'without account_user authentication' do
        it 'returns a 404' do
          stub_request[ "#{current_account.subdomain}" ]
          expect{ subject.authenticate_account_user! }.to raise_error Forbidden
          expect(subject.current_account_user).to be_nil
        end
      end
    end

  end

end
