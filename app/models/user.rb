class User < ApplicationRecord
  devise :database_authenticatable,
       :recoverable, :rememberable, :validatable

  enum role: { admin: 0, user: 1 }

  validates :role, :firstname, :lastname, presence: true

  strip_attributes
end
