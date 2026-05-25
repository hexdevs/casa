class Health < ApplicationRecord
  # The "singleton_guard" column is a unique column which must always be set to '0'
  # This ensures that only one Health row is created
  validates :singleton_guard, inclusion: {in: [0]}

  def self.instance
    first_or_create!(singleton_guard: 0)
  end
end
