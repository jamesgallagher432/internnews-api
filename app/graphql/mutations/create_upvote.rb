module Mutations
  class CreateUpvote < BaseMutation
    argument :link_id, ID, required: false

    type Types::UpvoteType

    def resolve(link_id: nil)
      if context[:current_user].blank?
        return GraphQL::ExecutionError.new("This user does not exist.")
      end

      check_for_upvote = Upvote.where(link: Link.find(link_id), user: context[:current_user]).first

      if check_for_upvote.blank?
        Upvote.create!(
          link: Link.find(link_id),
          user: context[:current_user]
        )
      else
        check_for_upvote.delete
        return check_for_upvote
      end
    end
  end
end
