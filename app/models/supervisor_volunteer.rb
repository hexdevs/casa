# relationship between a supervisor and volunteer
class SupervisorVolunteer < ApplicationRecord
  belongs_to :volunteer, class_name: "User"
  belongs_to :supervisor, class_name: "User"

  validates :supervisor_id, uniqueness: {scope: :volunteer_id}
  validates :volunteer_id, uniqueness: {scope: :is_active}, if: :is_active?
  validate :ensure_supervisor_and_volunteer_belong_to_same_casa_org, if: -> { supervisor.present? && volunteer.present? }

  private

  def ensure_supervisor_and_volunteer_belong_to_same_casa_org
    return if supervisor.casa_org_id == volunteer.casa_org_id

    errors.add(:volunteer, "and supervisor must belong to the same organization")
  end
end
