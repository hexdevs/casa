class CasaCaseEmancipationCategory < ApplicationRecord
  belongs_to :casa_case
  belongs_to :emancipation_category

  validates :casa_case_id, uniqueness: {scope: :emancipation_category_id}
end
