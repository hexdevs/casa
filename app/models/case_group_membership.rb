class CaseGroupMembership < ApplicationRecord
  belongs_to :case_group
  belongs_to :casa_case
  has_one :casa_org, through: :case_group
end
