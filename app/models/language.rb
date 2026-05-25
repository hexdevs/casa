class Language < ApplicationRecord
  belongs_to :casa_org
  has_many :user_languages
  has_many :users, through: :user_languages
  before_validation :strip_name

  validates :name, presence: true, uniqueness: {scope: :casa_org, case_sensitive: false}

  private

  def strip_name
    self.name = name.strip if name
  end
end
