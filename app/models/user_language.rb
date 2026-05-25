class UserLanguage < ApplicationRecord
  belongs_to :user
  belongs_to :language

  validates :language, uniqueness: {scope: :user}
end
