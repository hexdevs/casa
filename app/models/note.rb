class Note < ApplicationRecord
  belongs_to :notable, polymorphic: true
  belongs_to :creator, class_name: "User"
end
