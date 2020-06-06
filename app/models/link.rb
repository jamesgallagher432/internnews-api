class Link < ApplicationRecord
  belongs_to :user, optional: true

  has_many :upvotes
  has_many :comments
end
