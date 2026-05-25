class CaseCourtOrder < ApplicationRecord
  IMPLEMENTATION_STATUSES = {unimplemented: 1, partially_implemented: 2, implemented: 3}
  STANDARD_COURT_ORDERS = [
    "Birth certificate for the Respondent’s",
    "Domestic Violence Education/Group",
    "Educational monitoring for the Respondent",
    "Educational or Vocational referrals",
    "Family therapy",
    "Housing support for the [parent]",
    "Independent living skills classes or workshops",
    "Individual therapy for the [parent]",
    "Individual therapy for the Respondent",
    "Learners’ permit for the Respondent, drivers’ education and driving hours when needed",
    "No contact with (mother, father, other guardian)",
    "Parenting Classes (mother, father, other guardian)",
    "Psychiatric Evaluation and follow all recommendations (child, mother, father, other guardian)",
    "Substance abuse assessment for the [parent]",
    "Substance Abuse Evaluation and follow all recommendations (child, mother, father, other guardian)",
    "Substance Abuse Treatment (child, mother, father, other guardian)",
    "Supervised visits",
    "Supervised visits at DSS",
    "Therapy (child, mother, father, other guardian)",
    "Tutor for the Respondent",
    "Urinalysis (child, mother, father, other guardian)",
    "Virtual Visits",
    "Visitation assistance for the Respondent to see [family]"
  ].freeze

  belongs_to :casa_case
  belongs_to :court_date, optional: true

  validates :text, presence: true

  enum :implementation_status, IMPLEMENTATION_STATUSES

  def self.court_order_options
    STANDARD_COURT_ORDERS.map { |o| [o, o] }
  end

  def implementation_status_symbol
    case implementation_status
    when "implemented"
      "✅".freeze
    when "partially_implemented"
      "🕗".freeze
    else
      "❌".freeze
    end
  end
end
