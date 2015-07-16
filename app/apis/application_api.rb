require 'jwt'

class ApplicationApi < Grape::API
  format :json
  prefix 'api'
  extend Napa::GrapeExtenders

  # inspiration for JWT token authentication comes from
  # https://github.com/Foxandxss/rails-angular-jwt-example
  helpers do

    def token_authenticate!
      error!('Unauthorized. Invalid or expired token.', 401) unless current_user
    end

    def current_user
      # do not authenticate if authorization header missing
      return false unless header = headers['Authorization']

      # parse token from auth header and decode
      payload = decode_token header.split(' ').last

      # do not authenticate if token is invalid, expired, etc
      return false unless payload

      # if for some reason the user doesn't exist an error will
      # bubble up and render a 404 message
      user = User.find(payload[:user_id])

      # do not authenticate if the user account is locked
      return false if user.locked?

      # do not authenticate if token issue date is before user revoke date
      return false if user.revoke_date && Time.at(payload[:iat]) <= user.revoke_date

      # passed all checks, return the user object
      @current_user = user
    end

    def encode_token(payload={})
      fail ArgumentError, 'user_id is required' unless payload[:user_id]
      # encode token with 24 hour expiration
      token = JWT.encode(payload, Napa.secret_key_base, claims: {exp: 86400})
      Hashie::Mash.new access_token: token, created_at: Time.now
    end

    def decode_token(token)
      JWT.decode(token, Napa.secret_key_base).first
    rescue
      false
    end

  end

  mount UserApi
  mount AuthenticateApi
  mount CheckInApi

  add_swagger_documentation
end
