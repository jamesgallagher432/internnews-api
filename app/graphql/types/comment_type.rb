module Types
  class CommentType < Types::BaseObject
    field :id, ID, null: false
    field :user, Types::UserType, null: false
    field :description, String, null: false
    field :parent, [CommentType], null: true
    field :kids, [CommentType], null: true
  end
end
