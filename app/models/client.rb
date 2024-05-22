class Client < ApplicationRecord
  has_many :devis
  belongs_to :user
end
