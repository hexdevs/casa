class ChecklistItem < ApplicationRecord
  belongs_to :hearing_type
  has_one :casa_org, through: :hearing_type
  validates :category, presence: true
  validates :description, presence: true
end
