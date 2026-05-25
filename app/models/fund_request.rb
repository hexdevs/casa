class FundRequest < ApplicationRecord
  validates :submitter_email, presence: true
end
