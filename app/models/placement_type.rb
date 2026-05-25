class PlacementType < ApplicationRecord
  belongs_to :casa_org

  validates :name, presence: true
  scope :for_organization, ->(org) { where(casa_org: org) }
  scope :order_alphabetically, -> { order(:name) }
end
