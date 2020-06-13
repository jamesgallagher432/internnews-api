module Mutations
  class UpdateProfile < BaseMutation
    argument :username, String, required: false
    argument :email, String, required: false
    argument :about, String, required: false

    type Types::UserType

    def resolve(username: nil, email: nil, about: nil)
      if context[:current_user].blank?
        return GraphQL::ExecutionError.new("You must be authenticated to update your profile.")
      end

      user = User.find_by(id: context[:current_user].id)

      if username.blank?
        return GraphQL::ExecutionError.new("Please specify a username")
      end

      if email.blank?
        return GraphQL::ExecutionError.new("Please specify an email")
      end

      user.username = username
      user.email = email
      user.about = about
      user.save!

      return user
    end
  end
end
