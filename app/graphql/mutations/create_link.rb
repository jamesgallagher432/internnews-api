module Mutations
  class CreateLink < BaseMutation
    # arguments passed to the `resolve` method
    argument :description, String, required: true
    argument :url, String, required: true
    argument :title, String, required: true
    argument :slug, String, required: true

    # return type from the mutation
    type Types::LinkType

    def resolve(description: nil, url: nil, title: nil, slug: nil)
      Link.create!(
        description: description,
        url: url,
        title: title,
        slug: slug,
        user: context[:current_user]
      )
    end
  end
end
