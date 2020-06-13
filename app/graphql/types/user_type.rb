module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :username, String, null: false
    field :email, String, null: false
    field :about, String, null: false
    field :upvotes, [UpvoteType], null: false
    field :links, [LinkType], null: false
    field :comments, [CommentType], null: false
    field :is_admin, Boolean, null: false
    field :created_at, DateTimeType, null: false
    field :updated_at, DateTimeType, null: false
  end
end
