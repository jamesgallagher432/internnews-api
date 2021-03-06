module Types
  class MutationType < BaseObject
    field :create_link, mutation: Mutations::CreateLink
    field :create_upvote, mutation: Mutations::CreateUpvote
    field :create_comment, mutation: Mutations::CreateComment

    field :delete_link, mutation: Mutations::DeleteLink

    field :create_user, mutation: Mutations::CreateUser
    field :signin_user, mutation: Mutations::SignInUser
    field :update_profile, mutation: Mutations::UpdateProfile
    field :reset_password, mutation: Mutations::ResetPassword
  end
end
