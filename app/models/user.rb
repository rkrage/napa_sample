class User < ActiveRecord::Base

  has_many :check_ins, dependent: :destroy

  MIN_PASSWORD_LENGTH = 8

  validates_presence_of :email

  validates_uniqueness_of :email

  validates :password, length: { minimum: MIN_PASSWORD_LENGTH }, on: :create

  validates :password, length: { minimum: MIN_PASSWORD_LENGTH }, on: :update, allow_nil: true

  # eventually we would implement email verification, so this regex can be pretty stupid
  validates :email, format: { with: /.+@.+/, message: '%{value} is not a valid email address' }

  # create bcrypt validations
  has_secure_password

  # a bit of a hack to get rid of the password confirmation
  # which would most likely be handled by front-end javascript
  before_validation { self.password_confirmation = password }

  # if the account is locked don't even bother with bcrypt
  def authenticate(password)
    !self.locked? && super
  end

end
