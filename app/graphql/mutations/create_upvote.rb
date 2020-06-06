module Mutations
  class CreateUpvote < BaseMutation
    argument :link_id, ID, required: false

    type Types::UpvoteType

    def resolve(link_id: nil)
      Upvote.create!(
        link: Link.find(link_id),
        user: context[:current_user]
      )
    end
  end
end
