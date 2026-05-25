class AllCasaAdmin < ApplicationRecord
  prepend ActiveSupport::ToJsonWithActiveSupportEncoder
  include Roles

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :invitable, :recoverable, :validatable, :timeoutable, invite_for: 1.weeks

  def casa_admin?
    false
  end

  def supervisor?
    false
  end

  def volunteer?
    false
  end
end
