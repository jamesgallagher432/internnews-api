module Mutations
  class DeleteLink < BaseMutation
    argument :link_id, ID, required: false

    type Types::LinkType

    def resolve(link_id: nil)
      if context[:current_user].blank?
        return GraphQL::ExecutionError.new("You need to sign in.")
      end

      check_for_link = Link.find(link_id)

      if check_for_link.blank?
        return GraphQL::ExecutionError.new("This link does not exist.")
      end

      user = User.find_by(id: context[:current_user].id)

      if user.is_admin == false
        return GraphQL::ExecutionError.new("You need to be an admin to delete a link.")
      end

      comments = Comment.where(link: check_for_link).destroy_all
      upvotes = Upvote.where(link: check_for_link).destroy_all

      check_for_link.delete

      return check_for_link
    end
  end
end
