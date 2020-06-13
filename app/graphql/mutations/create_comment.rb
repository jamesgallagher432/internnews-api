module Mutations
  class CreateComment < BaseMutation
    argument :link_id, ID, required: true
    argument :comment_id, ID, required: false
    argument :description, String, required: true

    type Types::CommentType

    def resolve(link_id: nil, description: nil, comment_id: nil)
      if context[:current_user].blank?
        return GraphQL::ExecutionError.new("You must be authenticated to create a comment.")
      end

      if Link.find(link_id).blank?
        return GraphQL::ExecutionError.new("This link does not exist")
      end

      if description.blank?
        return GraphQL::ExecutionError.new("Comments cannot be blank")
      end

      if comment_id
        Comment.create!(
          link: Link.find(link_id),
          description: description,
          user: context[:current_user]
        )
        # Implement parent comments
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
