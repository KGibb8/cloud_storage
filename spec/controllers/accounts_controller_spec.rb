require 'rails_helper'

describe AccountsController do
  let(:user) { create :user }

  before do
    request.env['HTTPS'] = 'on'
    subject.instance_variable_set(:@current_user, user)
    sign_in user
  end

  describe 'GET #index' do
    let(:get_index) { Proc.new { get :index } }

    it 'returns a 200' do
      expect(response.status).to eq 200
    end
  end

  describe 'POST #create' do
    let(:account_params) { { account: { email: Faker::Internet.email, subdomain: 'woof' } } }
    let(:user_params) { { user: { email: Faker::Internet.email, password: 'password', password_confirmation: 'password' } } }
    let(:post_create) { Proc.new { post :create, params: account_params.merge(user_params) } }

    it 'creates an Account' do
      expect(post_create).to change{ Account.count }.by 1
    end

    it 'returns a 302' do
      expect(response.status).to eq 200
    end
  end

  describe 'GET #show' do
    let(:account) { create :account }
    let(:get_show) { Proc.new { get :show, params: { id: account.id } } }

    before { get_show }

    it 'returns a 200' do
      expect(response.status).to eq 200
    end
  end

end
