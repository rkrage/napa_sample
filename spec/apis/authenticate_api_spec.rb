require 'spec_helper'

def app
  ApplicationApi
end

describe AuthenticateApi do
  include Rack::Test::Methods

  let(:url) { "#{BASE_PATH}/authenticate" }

  describe 'POST /authenticate' do

    it 'grants access token with correct credentials' do
      post url, create(:user).slice(:email, :password)
      expect(last_response.status).to eq 201
      expect(JSON.parse(last_response.body)['access_token']).to_not be_nil
    end

    it 'shows error when credentials invalid' do
      post url, attributes_for(:user)
      expect(last_response.status).to eq 401
    end

  end


end
