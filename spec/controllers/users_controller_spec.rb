require 'rails_helper'
require 'users_controller'

RSpec.describe UsersController, type: :controller do
  let(:user_params) { FactoryBot.attributes_for(:user) }

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new user' do
        expect {
          post :create, params: user_params
        }.to change{ User.find_by_username(user_params[:username]).present? }.from(false).to(true)
      end

      it 'returns status 200' do
        post :create, params: user_params
        expect(response).to have_http_status(200)
        expect(json).to have_key('id')
        expect(json).to have_key('username')
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new user' do
        expect {
          post :create, params: { username: '', password: '' }
        }.not_to change{ User.find_by_username(user_params[:username]).present? }
      end

      it 'returns status 422' do
        post :create, params: { username: '', password: '' }
        expect(response).to have_http_status(422)
        expect(json['error']).to eq("Username can't be blank\nPassword can't be blank\nPassword is too short (minimum is 8 characters)")
      end
    end
  end

  describe 'POST #authenticate' do
    before do
      User.new(username: user_params[:username], password: user_params[:password]).save
    end

    context 'with valid credentials' do
      it 'returns status 200' do
        post :authenticate, params: { username: user_params[:username], password: user_params[:password] }
        expect(response).to have_http_status(200)
        expect(json).to have_key('id')
        expect(json).to have_key('username')
        expect(json).to have_key('token')
      end
    end

    context 'with invalid credentials' do
      it 'returns status 401' do
        post :authenticate, params: { username: user_params[:username], password: 'wrongpassword' }
        expect(response).to have_http_status(401)
        expect(json['error']).to eq('Username or password is invalid')
      end
    end
  end
end
