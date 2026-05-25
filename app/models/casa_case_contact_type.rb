class CasaCaseContactType < ApplicationRecord
  belongs_to :casa_case
  belongs_to :contact_type

  validates :casa_case_id, uniqueness: {scope: :contact_type_id}
end
