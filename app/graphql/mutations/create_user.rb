module Mutations
  class CreateUser < BaseMutation
    # often we will need input types for specific mutation
    # in those cases we can define those input types in the mutation class itself
    class AuthProviderSignupData < Types::BaseInputObject
      argument :credentials, Types::AuthProviderCredentialsInput, required: false
    end

    argument :username, String, required: true
    argument :auth_provider, AuthProviderSignupData, required: false

    type Types::UserType

    def resolve(username: nil, auth_provider: nil)
      if username.blank?
        return GraphQL::ExecutionError.new("Please specify a username")
      end

      if auth_provider&.[](:credentials)&.[](:email).blank?
        return GraphQL::ExecutionError.new("Please specify an email")
      end

      if auth_provider&.[](:credentials)&.[](:password).blank?
        return GraphQL::ExecutionError.new("Please specify a password")
      end

      check_for_username = User.where(username: username)

      if check_for_username.present?
        return GraphQL::ExecutionError.new("This username has been taken")
      end

      check_for_email = User.where(email: auth_provider&.[](:credentials)&.[](:email))

      if check_for_email.present?
        return GraphQL::ExecutionError.new("This email is being used by another account")
      end

      strength = PasswordStrength.test(username, auth_provider&.[](:credentials)&.[](:password))

      if !strength.valid?(:good)
        return GraphQL::ExecutionError.new("Please choose a more secure password")
      end

      User.create!(
        username: username,
        email: auth_provider&.[](:credentials)&.[](:email),
        password: auth_provider&.[](:credentials)&.[](:password),
        about: "I have just signed up to Intern News.",
        is_admin: false
      )
    end
  end
end
