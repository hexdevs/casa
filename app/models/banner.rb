class Banner < ApplicationRecord
  belongs_to :casa_org
  belongs_to :user
  has_rich_text :content

  scope :active, -> { where(active: true) }

  validates :name, presence: true
  validates :content, presence: true
  validate :only_one_banner_is_active_per_organization
  validate :expires_at_must_be_in_future

  def expired?
    expired = expires_at && Time.current > expires_at
    update(active: false) if active && expired
    expired
  end

  # `expires_at` is stored in the database as UTC, but timezone information will be stripped before displaying on frontend
  # so this method converts the time to the user's timezone before displaying it
  def expires_at_in_time_zone(timezone)
    expires_at&.in_time_zone(timezone)
  end

  private

  def only_one_banner_is_active_per_organization
    is_other_banner_active = casa_org.banners.where.not(id: id).any?(&:active?)
    more_than_one_banner_active = is_other_banner_active && active?
    if more_than_one_banner_active
      errors.add(:base, "Only one banner can be active at a time. Mark the other banners as not active before marking this banner as active.")
    end
  end

  # Validation using line below doesn't work with `travel_to` in specs. Must use detailed method
  # validates_comparison_of :expires_at, greater_than: Time.current, message: "must take place in the future (after #{Time.current})", allow_blank: true
  def expires_at_must_be_in_future
    if expires_at.present? && expires_at < Time.current
      errors.add(:expires_at, "must take place in the future (after #{Time.current})")
    end
  end
end
