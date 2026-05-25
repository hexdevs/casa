class PatchNote < ApplicationRecord
  validates :note, presence: true

  belongs_to :patch_note_type
  belongs_to :patch_note_group

  scope :notes_available_for_user, ->(user) {
    joins(:patch_note_group)
      .where("POSITION(? IN value)>0", user.type)
      .where("patch_notes.created_at < ?", Health.instance.latest_deploy_time)
  }
end
