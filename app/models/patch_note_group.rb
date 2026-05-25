class PatchNoteGroup < ApplicationRecord
  validates :value, uniqueness: true, presence: true
end
