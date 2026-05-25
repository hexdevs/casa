class CustomOrgLink < ApplicationRecord
  TEXT_MAX_LENGTH = 30

  belongs_to :casa_org
  validates :text, :url, presence: true
  validates :text, length: {maximum: TEXT_MAX_LENGTH}
  validates :active, inclusion: {in: [true, false]}
  validates :url, url: true

  before_save :trim_name

  private

  def trim_name
    self.text = text.strip if text.present?
  end
end
