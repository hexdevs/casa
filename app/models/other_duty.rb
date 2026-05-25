class OtherDuty < ApplicationRecord
  belongs_to :creator, class_name: "User"
  delegate :type, to: :creator, prefix: true

  validates :notes, presence: true
  validates :occurred_at, comparison: {
    less_than_or_equal_to: -> { 1.year.from_now },
    message: "is not valid. Occured on date must be within one year from today."
  }
  validates :occurred_at, comparison: {
    greater_than_or_equal_to: "1989-01-01".to_date,
    message: "is not valid. Occured on date cannot be prior to 1/1/1989."
  }
end
