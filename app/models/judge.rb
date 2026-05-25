class Judge < ApplicationRecord
  belongs_to :casa_org

  validates :name, presence: true, uniqueness: {scope: %i[casa_org]}
  default_scope { order(name: :asc) }
  scope :for_organization, ->(org) { where(casa_org: org).order(:name) }
  scope :active, -> { where(active: true) }
end
