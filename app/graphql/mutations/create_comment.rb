module Mutations
  class CreateComment < BaseMutation
    argument :link_id, ID, required: false
    argument :description, String, required: true

    type Types::CommentType

    def resolve(link_id: nil, description: nil)
      Comment.create!(
        link: Link.find(link_id),
        description: description,
        user: context[:current_user]
      )
    end
  end
end
