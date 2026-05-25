class PatchNoteType < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true, presence: true
end
