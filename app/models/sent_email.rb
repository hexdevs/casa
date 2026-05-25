class SentEmail < ApplicationRecord
  belongs_to :user
  belongs_to :casa_org

  validates :mailer_type, presence: true
  validates :category, presence: true
  validates :sent_address, presence: true

  scope :for_organization, ->(org) { where(casa_org: org) }
end
