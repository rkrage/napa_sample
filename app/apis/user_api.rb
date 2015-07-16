class UserApi < Grape::API

  namespace :users do

    desc 'Create a user'
    params do
      requires :email, type: String, desc: 'Email address of the user'
      requires :password, type: String, desc: 'Password of the user'
    end
    post do
      user = User.create!(permitted_params)
      present user, with: UserRepresenter
    end

  end

  namespace :user do

    before do
      token_authenticate!
    end

    desc 'Get currently signed in user'
    get do
      present @current_user, with: UserRepresenter
    end

    desc 'Update currently signed in user'
    params do
      optional :email, type: String, desc: 'Email address of the user'
      optional :password, type: String, desc: 'Password of the user'
    end
    put do
      @current_user.update_attributes!(permitted_params)
      present @current_user, with: UserRepresenter
    end

  end

end
