module Mutations
  class SignInUser < BaseMutation
    null true

    argument :credentials, Types::AuthProviderCredentialsInput, required: false

    field :token, String, null: true
    field :user, Types::UserType, null: true

    def resolve(credentials: nil)
      # basic validation
      if credentials[:username].blank?
        return GraphQL::ExecutionError.new("Please specify an username")
      end

      if credentials[:password].blank?
        return GraphQL::ExecutionError.new("Please specify a password")
      end

      user = User.find_by username: credentials[:username]

      if !user
        return GraphQL::ExecutionError.new("No user exists with this username")
      end

      if !user.authenticate(credentials[:password])
        return GraphQL::ExecutionError.new("Your password is incorrect")
      end

      token = AuthToken.token(user)

      context[:session][:token] = token

      OpenStruct.new({
        token: token,
        user: user
      })
    end
  end
end
