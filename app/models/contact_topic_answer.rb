class ContactTopicAnswer < ApplicationRecord
  belongs_to :case_contact
  belongs_to :contact_topic, optional: true
  acts_as_paranoid

  has_one :casa_case, through: :case_contact
  has_one :casa_org, through: :case_contact
  # case_contact.casa_org may be nil for draft contacts, use for fallback:
  has_one :contact_creator, through: :case_contact, source: :creator
  has_one :contact_creator_casa_org, through: :contact_creator, source: :casa_org

  validates :selected, inclusion: [true, false]
  validates :contact_topic, presence: {if: ->(cta) { cta.value&.present? }, message: :must_be_selected}
end
