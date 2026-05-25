class CasaCaseEmancipationOption < ApplicationRecord
  belongs_to :casa_case
  belongs_to :emancipation_option

  validates :casa_case_id, uniqueness: {scope: :emancipation_option_id}
end
