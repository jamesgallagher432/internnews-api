module Types
  class PostType < Types::BaseObject
    field :id, ID, null: false
    field :url, String, null: false
    field :text, String, null: false
    field :title, String, null: false
    field :slug, String, null: false
  end
end
