class User < ApplicationRecord
  has_many :providers
  has_many :clients
  has_many :devis
  has_many :factures

  devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :validatable

  enum role: { admin: 0, user: 1 }

  validates :role, :firstname, :lastname, presence: true

  strip_attributes
end
