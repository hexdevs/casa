class Supervisor < User
  devise :invitable, invite_for: 2.weeks

  has_many :supervisor_volunteers
  has_many :active_supervisor_volunteers, -> { where(is_active: true) }, class_name: "SupervisorVolunteer", foreign_key: "supervisor_id"
  has_many :unassigned_supervisor_volunteers, -> { where(is_active: false) }, class_name: "SupervisorVolunteer", foreign_key: "supervisor_id"

  has_many :volunteers, -> { includes(:supervisor_volunteer).order(:display_name) }, through: :active_supervisor_volunteers
  has_many :volunteers_ever_assigned, -> { includes(:supervisor_volunteer).order(:display_name) }, through: :supervisor_volunteers, source: :volunteer

  scope :active, -> { where(active: true) }

  # Activates supervisor.
  def activate
    update(active: true)
  end

  # Deactivates supervisor and unassign all volunteers.
  def deactivate
    transaction do
      updated = update(active: false)
      if updated
        supervisor_volunteers.update_all(is_active: false)
      end

      updated
    end
  end

  def change_to_admin!
    becomes!(CasaAdmin).save
  end

  def pending_volunteers
    Volunteer.where(invited_by_id: id).or(
      Volunteer.where(id: volunteers.pluck(:id))
    ).where(invitation_accepted_at: nil).where.not(invitation_created_at: nil)
  end

  def inactive_volunteers
    recent_case_contact_volunteer_ids = volunteers.joins(:case_contacts).where(
      case_contacts: {created_at: 30.days.ago..}
    ).pluck(:id)

    volunteers.no_recent_sign_in.where.not(id: recent_case_contact_volunteer_ids)
  end

  def recently_unassigned_volunteers
    unassigned_supervisor_volunteers.joins(:volunteer).includes(:volunteer)
      .where(updated_at: 1.week.ago..Time.zone.now).map(&:volunteer)
  end
end
