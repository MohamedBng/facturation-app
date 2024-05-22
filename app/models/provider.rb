class Provider < ApplicationRecord
  include ImageUploader::Attachment(:logo)
  has_many :devis, dependent: :destroy
  has_many :factures, dependent: :destroy
  belongs_to :user

  validates :name, presence: true

  strip_attributes
end
