class User < ApplicationRecord
  has_secure_password

  validates :username, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :upvotes
  has_many :links
  has_many :comments
end
