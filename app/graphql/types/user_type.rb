module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :username, String, null: false
    field :email, String, null: false
    field :upvotes, [UpvoteType], null: false
    field :links, [LinkType], null: false
    field :comments, [Types::CommentType], null: false
  end
end
