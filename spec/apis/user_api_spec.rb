require 'spec_helper'

def app
  ApplicationApi
end

describe UserApi do
  include Rack::Test::Methods

  let(:authenticated_user_url) { "#{BASE_PATH}/user" }

  let(:create_user_url) { "#{BASE_PATH}/users" }

  let(:valid_fields) { %w(id email created_at updated_at) }

  describe 'with auth' do

    include_context 'authenticate'

    describe 'GET /user' do

      it 'returns the currently signed in user' do
        get authenticated_user_url
        expect(last_response.status).to eq 200
        expect(JSON.parse(last_response.body)).to eq @user
      end

    end

    describe 'PUT /user' do

      it 'updates the password of currently signed in user' do
        old_password_digest = User.find(@user['id']).password_digest
        put authenticated_user_url, attributes_for(:user).slice(:password)
        expect(last_response.status).to eq 200
        expect(old_password_digest).to_not eq User.find(@user['id']).password_digest
      end

      it 'updates the email of currently signed in user' do
        @user['email'] = attributes_for(:user)[:email]
        put authenticated_user_url, @user.slice('email')
        expect(last_response.status).to eq 200
        new_user = JSON.parse(last_response.body)
        expect(new_user['email']).to eq @user['email']
      end

    end

  end

  describe 'without auth' do

    include_context 'invalid token'

    describe 'POST /users' do

      it 'creates a new user' do
        user = attributes_for(:user)
        post create_user_url, user
        expect(last_response.status).to eq 201
        new_user = JSON.parse(last_response.body)
        valid_fields.each do |key|
          expect(new_user.key? key).to be true
        end
        expect(new_user['email']).to eq user[:email]
      end

      it 'shows error when missing params' do
        post create_user_url, {}
        expect(last_response.status).to eq 400
      end

    end

    describe 'GET /user' do

      it 'shows not authenticated error' do
        get authenticated_user_url
        expect(last_response.status).to eq 401
      end

    end

    describe 'PUT /user' do

      it 'show not authenticated error' do
        put authenticated_user_url, attributes_for(:user).slice(:password)
        expect(last_response.status).to eq 401
      end

    end

  end

end
