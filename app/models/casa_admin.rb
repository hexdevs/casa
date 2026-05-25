class CasaAdmin < User
  prepend ActiveSupport::ToJsonWithActiveSupportEncoder

  devise :invitable, invite_for: 2.weeks

  default_scope { order(email: :asc) }

  def activate
    update(active: true)
  end

  def deactivate
    update(active: false)
  end

  def change_to_supervisor!
    becomes!(Supervisor).save
  end
end
