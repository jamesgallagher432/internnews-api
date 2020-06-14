module Mutations
  class CreateComment < BaseMutation
    argument :link_id, ID, required: false
    argument :comment_id, ID, required: false
    argument :description, String, required: true

    type Types::CommentType

    def resolve(link_id: nil, description: nil, comment_id: nil)
      if context[:current_user].blank?
        return GraphQL::ExecutionError.new("You need to sign in.")
      end

      if link_id
        if Link.find(link_id).blank?
          return GraphQL::ExecutionError.new("This link does not exist")
        end
      end

      if comment_id
        if Comment.find(comment_id).blank?
          return GraphQL::ExecutionError.new("This comment does not exist")
        end
      end

      if comment_id.blank? && link_id.blank?
          return GraphQL::ExecutionError.new("Please specify either a link or comment id")
      end

      if description.blank?
        return GraphQL::ExecutionError.new("Comments cannot be blank")
      end

      if comment_id
        Comment.create!(
          link: Link.find_by(id: Comment.find_by(comment_id).link_id),
          description: description,
          user: context[:current_user],
          parent_id: Comment.find_by(id: comment_id).id
        )
      else
        Comment.create!(
          link: Link.find(link_id),
          description: description,
          user: context[:current_user]
        )
      end
    end
  end
end
