require 'rails_helper'

describe AccountsController do

  describe 'GET #index' do
    let(:get_index) { Proc.new { get :index } }

    it 'assigns @accounts' do
      expect(get_index).to change{ assigns :accounts }
    end

    it 'returns a 200' do
      expect(response.status).to eq 200
    end

  end

  describe 'POST #create' do
    let(:account_params) { { account: { email: Faker::Internet.email, subdomain: Faker::StarWars.planet.underscore.gsub(' ','_') } } }
    let(:post_create) { Proc.new { post :create, params: account_params } }

    it 'creates an Account' do
      expect(post_create).to change{ Account.count }.by 1
    end

    it 'returns a 302' do
      expect(response.status).to eq 200
    end
  end

end
