module Mutations
  class ResetPassword < BaseMutation
    argument :old_password, String, required: false
    argument :new_password, String, required: false

    type Types::UserType

    def resolve(old_password: nil, new_password: nil)
      if context[:current_user].blank?
        return GraphQL::ExecutionError.new("You must be authenticated to update your profile.")
      end

      user = User.find_by(id: context[:current_user].id)

      if old_password.blank?
        return GraphQL::ExecutionError.new("Please specify your old password")
      end

      if new_password.blank?
        return GraphQL::ExecutionError.new("Please specify a new password")
      end

      if !user.authenticate(old_password)
        return GraphQL::ExecutionError.new("Your old password is incorrect")
      end

      strength = PasswordStrength.test(user.username, new_password)

      if !strength.valid?(:good)
        return GraphQL::ExecutionError.new("Please choose a more secure password")
      end

      user.password = new_password
      user.save!

      return user
    end
  end
end
