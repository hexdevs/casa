class EmancipationOption < ApplicationRecord
  belongs_to :emancipation_category
  has_many :casa_case_emancipation_options, dependent: :destroy
  has_many :casa_cases, through: :casa_case_emancipation_options

  validates :name, presence: true, uniqueness: {scope: :emancipation_category_id}

  scope :category_options, ->(emancipation_category_id) {
    where(emancipation_category_id: emancipation_category_id)
  }

  scope :options_with_category_and_case, ->(emancipation_category_id, casa_case_id) {
    joins(:casa_cases)
      .where(casa_case_emancipation_options: {casa_case_id: casa_case_id})
      .where(emancipation_category_id: emancipation_category_id)
  }
end
