class Users::Authenticate < ActiveInteraction::Base
  string :username
  string :password

  def execute
    user = User.authenticate(username, password)
    if user
      AuthenticationSerializer.new(user).as_json
    else
      errors.add(:username_or_password, 'is invalid')
    end
  end
end