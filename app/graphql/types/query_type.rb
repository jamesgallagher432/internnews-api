module Types
  class QueryType < BaseObject
    # queries are just represented as fields
    # `all_links` is automatically camelcased to `allLinks`
    field :all_links, [LinkType], null: false do
      argument :user, Int, required: false
      argument :link, Int, required: false
    end

    field :all_users, [UserType], null: false do
      argument :user, Int, required: false
    end

    field :all_comments, [CommentType], null: false do
      argument :user, Int, required: false
      argument :link, Int, required: false
    end

    field :current_user, [UserType], null: false

    # this method is invoked, when `all_link` fields is being resolved
    def all_links(user: nil, link: nil)
      if user
        Link.where(user: user)
      elsif link
        Link.where(id: link)
      else
        Link.all.order(created_at: :desc)
      end
    end

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
