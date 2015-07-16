class User < ActiveRecord::Base

  has_many :check_ins, dependent: :destroy

  # create bcrypt validations
  has_secure_password

  # a bit of a hack to get rid of the password confirmation
  # which would most likely be handled by front-end javascript
  before_validation { self.password_confirmation ||= password }

  # if the account is locked don't even bother with bcrypt
  def authenticate(password)
    !self.locked? && super
  end

end
