class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :user_type, :phone, :address, :created_at, :updated_at, :token
end
