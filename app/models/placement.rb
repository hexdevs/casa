class Placement < ApplicationRecord
  belongs_to :casa_case
  belongs_to :placement_type
  belongs_to :creator, class_name: "User"
  has_one :casa_org, through: :casa_case

  validates :placement_started_at, comparison: {
    greater_than_or_equal_to: "1989-01-01".to_date,
    message: "cannot be prior to 1/1/1989.",
    allow_nil: true
  }
  validates :placement_started_at, comparison: {
    less_than_or_equal_to: -> { 1.year.from_now },
    message: "must not be more than one year in the future.",
    allow_nil: true
  }
end
