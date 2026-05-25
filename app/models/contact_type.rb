class ContactType < ApplicationRecord
  belongs_to :contact_type_group
  has_one :casa_org, through: :contact_type_group

  has_many :casa_case_contact_types
  has_many :casa_cases, through: :casa_case_contact_types

  validates :name, presence: true, uniqueness: {scope: :contact_type_group_id,
                                                message: "should be unique per contact type group"}

  scope :for_organization, ->(org) {
    joins(:contact_type_group)
      .where(contact_type_groups: {casa_org: org})
  }
  scope :active, -> { where(active: true) }
  scope :alphabetically, -> { order(:name) }
end
