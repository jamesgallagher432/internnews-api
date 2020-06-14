require 'search_object'
require 'search_object/plugin/graphql'
require 'graphql/query_resolver'

class Resolvers::LinksSearch
  include SearchObject.module(:graphql)

  scope { Link.all }

  type [Types::LinkType]

  class LinkFilter < ::Types::BaseInputObject
    argument :OR, [self], required: false
    argument :description_contains, String, required: false
    argument :url_contains, String, required: false
  end

  option :filter, type: LinkFilter, with: :apply_filter
  option :first, type: types.Int, with: :apply_first
  option :skip, type: types.Int, with: :apply_skip
  option :user, type: types.Int, with: :apply_user
  option :link, type: types.String, with: :apply_link
  option :order, type: types.String, with: :apply_order

  def apply_filter(scope, value)
    branches = normalize_filters(value).reduce { |a, b| a.or(b) }
    scope.merge branches
  end

  def normalize_filters(value, branches = [])
    scope = Link.all
    scope = scope.where('description LIKE ?', "%#{value[:description_contains]}%") if value[:description_contains]
    scope = scope.where('url LIKE ?', "%#{value[:url_contains]}%") if value[:url_contains]

    branches << scope

    value[:OR].reduce(branches) { |s, v| normalize_filters(v, s) } if value[:OR].present?

    branches
  end

  def apply_first(scope, value)
    scope.limit(value)
  end

  def apply_skip(scope, value)
    scope.offset(value)
  end

  def apply_user(scope, user)
    scope.where(user: user)
  end

  def apply_link(scope, link)
    scope.where(slug: link)
  end

  def apply_order(scope, type)
    if type === "top"
      scope
        .where('links.created_at > ? AND links.created_at < ?',
          Date.today.last_month.beginning_of_month,
          Date.today)
        .left_joins(:upvotes)
        .group(:id)
        .order('COUNT(upvotes.id) DESC')
    elsif type == "best"
      scope
        .left_joins(:upvotes)
        .group(:id)
        .order('COUNT(upvotes.id) DESC')
    else
      scope
        .where('created_at > ? AND created_at < ?',
          Date.today.last_month.beginning_of_month,
          Date.today)
        .order(created_at: :desc)
    end
  end

  def fetch_results
    # NOTE: Don't run QueryResolver during tests
    return super unless context.present?

    GraphQL::QueryResolver.run(Link, context, Types::LinkType) do
      super
    end
  end
end
