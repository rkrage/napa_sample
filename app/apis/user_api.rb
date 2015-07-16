class UserApi < Grape::API

  desc 'Create a new user'
  params do
    requires :email, type: String, desc: 'Email address of the user'
    requires :password, type: String, desc: 'Password of the user'
  end
  post do
    user = User.create!(permitted_params)
    present user, with: UserRepresenter
  end

  desc 'Get currently signed in user'
  get '/me' do
    token_authenticate!
    present @current_user, with: UserRepresenter
  end

end
