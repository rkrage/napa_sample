shared_context 'authenticate' do

  before(:each) do
    @user = create :user
    post "#{BASE_PATH}/authenticate", @user.slice(:email, :password)
    token = JSON.parse(last_response.body)['access_token']
    header 'Authorization', "Bearer #{token}"
    @user = JSON.parse(UserRepresenter.new(@user).to_json)
  end

end

shared_context 'invalid token' do

  before(:all) do
    header 'Authorization', 'Bearer gibberish'
  end

end
