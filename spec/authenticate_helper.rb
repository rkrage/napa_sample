shared_context 'authenticate' do

  before(:all) do
    user = create :user
    post "#{BASE_PATH}/authenticate", user.slice(:email, :password)
    token = JSON.parse(last_response.body)['access_token']
    header 'Authorization', "Bearer #{token}"
  end

end
