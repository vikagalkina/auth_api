class AuthenticationSerializer < UserSerializer
  attributes :token

  def token
    JsonWebToken.encode({ user_id: object.id })
  end
end
