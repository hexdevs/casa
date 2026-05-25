class LearningHour < ApplicationRecord
  belongs_to :user
  belongs_to :learning_hour_type
  belongs_to :learning_hour_topic, optional: true
  has_one :casa_org, through: :user

  validates :duration_minutes, presence: true
  validates :duration_minutes, numericality: {greater_than: 0, message: "and hours (total duration) must be greater than 0"}, if: :zero_duration_hours?
  validates :name, presence: {message: "/ Title cannot be blank"}
  validates :occurred_at, presence: true
  validate :occurred_at_not_in_future
  validates :occurred_at, comparison: {
    greater_than_or_equal_to: "1989-01-01".to_date,
    message: "is not valid: Occurred on Date cannot be prior to 1/1/1989.",
    allow_nil: true
  }
  validates :learning_hour_topic, presence: true, if: :user_org_learning_topic_enable?

  scope :supervisor_volunteers_learning_hours, ->(supervisor_id) {
    joins(user: :supervisor_volunteer)
      .where(supervisor_volunteers: {supervisor_id: supervisor_id})
      .select("users.id as user_id, users.display_name, SUM(learning_hours.duration_minutes + learning_hours.duration_hours * 60) AS total_time_spent")
      .group("users.display_name, users.id")
      .order("users.display_name")
  }

  scope :all_volunteers_learning_hours, ->(casa_admin_org_id) {
    joins(:user)
      .where(users: {casa_org_id: casa_admin_org_id})
      .select("users.id as user_id, users.display_name, SUM(learning_hours.duration_minutes + learning_hours.duration_hours * 60) AS total_time_spent")
      .group("users.display_name, users.id")
      .order("users.display_name")
  }

  private

  def zero_duration_hours?
    duration_hours == 0
  end

  def occurred_at_not_in_future
    return false if !occurred_at

    if occurred_at > Date.today
      errors.add(:date, "cannot be in the future")
    end
  end

  def user_org_learning_topic_enable?
    user.casa_org.learning_topic_active
  end
end
