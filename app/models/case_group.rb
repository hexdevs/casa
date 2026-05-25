class CaseGroup < ApplicationRecord
  belongs_to :casa_org
  has_many :case_group_memberships, dependent: :destroy
  has_many :casa_cases, through: :case_group_memberships
  before_validation :strip_name

  validates :case_group_memberships, presence: true

  validates :name, presence: true, uniqueness: {scope: :casa_org, case_sensitive: false}

  private

  def strip_name
    self.name = name.strip if name
  end
end
