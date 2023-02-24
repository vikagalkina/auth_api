class Users::Create < ActiveInteraction::Base
  string :username
  string :password

  def execute
    user = User.new(username: username, password: password)
    unless user.save
      errors.merge!(user.errors)
    end

    UserSerializer.new(user).as_json
  end
end