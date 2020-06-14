module Types
  class QueryType < BaseObject
    # queries are just represented as fields
    # `all_links` is automatically camelcased to `allLinks`
    add_field GraphQL::Types::Relay::NodeField
    add_field GraphQL::Types::Relay::NodesField

    field :all_links, [LinkType], null: false do
      argument :user, Int, required: false
      argument :link, String, required: false
      argument :order, String, required: false
    end

    field :all_links, resolver: Resolvers::LinksSearch

    field :all_users, [UserType], null: false do
      argument :user, Int, required: false
    end

    field :all_comments, [CommentType], null: false do
      argument :user, Int, required: false
      argument :link, Int, required: false
    end

    field :current_user, [UserType], null: false

    def all_users(user: nil)
      if user
        User.where(id: user).limit(1)
      else
        User.all
      end
    end

    def all_comments(user: nil, link: nil)
      if user
        Comment.where(user: user)
      elsif link
        Comment.where(link: link)
      else
        Comment.all
      end
    end

    def current_user
      User.where(id: context[:current_user])
    end
  end
end
