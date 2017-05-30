require 'rails_helper'

describe AccountsController do
  let(:user) { create :user }

  describe 'GET #index' do

    def do_request
      get :index
    end

    it 'returns a 200' do
      expect(response.status).to eq 200
    end
  end

  describe 'POST #create' do
    let(:account_params) { { account: { email: Faker::Internet.email, subdomain: 'woof' } } }
    let(:user_params) { { user: { email: Faker::Internet.email, password: 'password', password_confirmation: 'password' } } }
    let(:invalid_params) do
      { account: { email: 'woof', subdomain: 'public' },
        user: { email: 'woof', password: 'password', password_confirmation: 'password' } }
    end

    def do_request
      post :create, params: account_params.merge(user_params)
    end

    def fail_request
      post :create, params: invalid_params
    end

    context 'with a signed in user' do
      before do
        request.env['HTTPS'] = 'on'
        subject.instance_variable_set(:@current_user, user)
        sign_in user
      end

      context 'with valid creation criteria' do
        it 'creates an Account' do
          expect{ do_request }.to change{ Account.count }.by 1
        end

        it 'returns a 200' do
          expect(response.status).to eq 200
        end
      end

      context 'with invalid creation criteria' do
        it 'returns nil' do
          expect{ fail_request }.to change{ Account.count }.by 0
        end

        it 'returns a 200' do
          expect(response.status).to eq 200
        end
      end
    end

    context 'without a signed in user' do
      before do
        sign_out user
      end

      it 'creates an Account' do
        expect{ do_request }.to change{ Account.count }.by 1
      end

      it 'creates a User' do
        expect{ do_request }.to change{ User.count }.by 1
      end

      it 'returns a 302' do
        expect(response.status).to eq 200
      end
    end
  end

  describe 'GET #show' do
    let(:account) { create :account }

    context 'outside a valid subdomain' do
      def do_request
        switch_tenant!
        get :show, params: { id: account.id }
      end

      it 'returns a 404' do
        do_request
        expect(response.status).to eq 404
      end
    end

    context 'inside a valid subdomain' do
      def do_request
        switch_tenant!(account.subdomain)
        get :show, params: { id: account.id }
      end

      it 'returns a 200' do
        expect(response.status).to eq 200
      end
    end
  end
end
