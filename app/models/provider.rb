class Provider < ApplicationRecord
  include ImageUploader::Attachment(:logo)
  has_many :devis, dependent: :destroy

  validates :name, presence: true

  strip_attributes
end
