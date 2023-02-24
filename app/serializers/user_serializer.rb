class UserSerializer < ActiveModel::Serializer
  attributes :id, :username

  def read_attribute_for_serialization(attr)
    if respond_to?(attr)
      send(attr)
    else
      object.public_send(attr)
    end
  end
end