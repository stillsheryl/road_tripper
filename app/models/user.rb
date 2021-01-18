class User < ApplicationRecord
  validates :email, uniqueness: { case_sensitive: false }, presence: true
  validates_presence_of :password, require: true

  has_secure_password
end
