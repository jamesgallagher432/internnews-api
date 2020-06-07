module Types
  class CommentType < Types::BaseObject
    field :id, ID, null: false
    field :user, Types::UserType, null: false
    field :description, String, null: false
  end
end
