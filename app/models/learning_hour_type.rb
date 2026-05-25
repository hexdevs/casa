class LearningHourType < ApplicationRecord
  belongs_to :casa_org

  validates :name, presence: true, uniqueness: {scope: %i[casa_org], case_sensitive: false}
  before_validation :strip_name
  default_scope { order(position: :asc, name: :asc) }
  scope :for_organization, ->(org) { where(casa_org: org).order(:name) }
  scope :active, -> { where(active: true) }

  private

  def strip_name
    self.name = name.strip if name
  end
end
