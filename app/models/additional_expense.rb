class AdditionalExpense < ApplicationRecord
  belongs_to :case_contact
  has_one :casa_case, through: :case_contact
  has_one :casa_org, through: :case_contact
  # case_contact.casa_org may be nil for draft contacts, use for fallback:
  has_one :contact_creator, through: :case_contact, source: :creator
  has_one :contact_creator_casa_org, through: :contact_creator, source: :casa_org

  validates :other_expenses_describe, presence: true, if: :describe_required?

  alias_attribute :amount, :other_expense_amount
  alias_attribute :describe, :other_expenses_describe

  def describe_required?
    other_expense_amount&.positive?
  end
end
