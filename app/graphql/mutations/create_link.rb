module Mutations
  class CreateLink < BaseMutation
    # arguments passed to the `resolve` method
    argument :description, String, required: false
    argument :url, String, required: false
    argument :title, String, required: false

    # return type from the mutation
    type Types::LinkType

    def resolve(description: nil, url: nil, title: nil)
      if context[:current_user].blank?
        return GraphQL::ExecutionError.new("You must be authenticated to create a link.")
      end

      if title.blank?
        return GraphQL::ExecutionError.new("Please specify a link title")
      end

      if url.blank? && description.blank?
        return GraphQL::ExecutionError.new("Please specify a link url or description")
      end

      if url.present? && description.present?
        return GraphQL::ExecutionError.new("Please specify a link or a description")
      end

      Link.create!(
        description: description,
        url: url,
        title: title,
        slug: "#{title.parameterize}-#{rand(0..10)}",
        user: context[:current_user]
      )
    end
  end
end
