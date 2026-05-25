class Followup < ApplicationRecord
  belongs_to :followupable, polymorphic: true, optional: true # TODO polymorph: remove optional after data is safely migrated
  belongs_to :case_contact
  has_one :casa_org, through: :case_contact
  belongs_to :creator, class_name: "User"
  enum :status, {requested: 0, resolved: 1}

  validate :uniqueness_of_requested

  def self.in_organization(casa_org)
    Followup.joins(case_contact: :casa_case).where(casa_cases: {casa_org_id: casa_org.id})
  end

  def uniqueness_of_requested
    return if resolved?
    return if existing_requested_followup?

    errors.add(:base, "Only 1 Followup can be in requested status.")
  end

  private

  def existing_requested_followup?
    Followup.where(status: :requested, case_contact: case_contact).count == 0
  end
end
