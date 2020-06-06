module Types
  class QueryType < BaseObject
    # queries are just represented as fields
    # `all_links` is automatically camelcased to `allLinks`
    field :all_links, [LinkType], null: false do
      argument :user, Int, required: false
    end

    field :all_comments, [CommentType], null: false do
      argument :user, Int, required: false
      argument :link, Int, required: false
    end

    # this method is invoked, when `all_link` fields is being resolved
    def all_links(user: nil)
      if user
        Link.where(user: user)
      else
        Link.all
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
  end
end
