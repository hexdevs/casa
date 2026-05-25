class CaseContactContactType < ApplicationRecord
  belongs_to :case_contact
  belongs_to :contact_type

  validates :case_contact_id, uniqueness: {scope: :contact_type_id}
end
