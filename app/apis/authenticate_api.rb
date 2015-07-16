class AuthenticateApi < Grape::API

  namespace :authenticate do

    desc 'Authenticate user and retrieve access token'
    params do
      requires :email, type: String, desc: 'Email address of the user'
      requires :password, type: String, desc: 'Password of the user'
    end
    post do
      user = User.find_by_email(params[:email])

      if user && user.authenticate(params[:password])
        token = encode_token user_id: user.id
        present token, with: TokenRepresenter
      else
        # generic message so we don't give attackers any ammo
        error!('Unauthorized.', 401)
      end
    end

  end

end
