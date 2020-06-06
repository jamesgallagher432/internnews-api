require 'test_helper'

class Mutations::CreateLinkTest < ActiveSupport::TestCase
  def perform(user: nil, **args)
    Mutations::CreateLink.new(object: nil, field: nil, context: {}).resolve(args)
  end

  test 'create a new link' do
    link = perform(
      url: 'http://example.com',
      description: 'description',
      title: 'title',
      slug: 'slug'
    )

    assert link.persisted?
    assert_equal link.description, 'description'
    assert_equal link.url, 'http://example.com'
    assert_equal link.title, 'title'
    assert_equal link.slug, 'slug'
  end
end
