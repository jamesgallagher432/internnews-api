module Mutations
  class UpdateProfile < BaseMutation
    argument :username, String, required: true
    argument :email, String, required: true
    argument :about, String, required: true

    type Types::UserType

    def resolve(username: nil, email: nil, about: nil)
      # Replace this with actual user code session[:current_user]

      user = User.first

      user.username = username
      user.email = email
      user.about = about
      user.save!

      return user
    end
  end
end
