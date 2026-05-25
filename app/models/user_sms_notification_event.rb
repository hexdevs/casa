class UserSmsNotificationEvent < ApplicationRecord
  belongs_to :user
  belongs_to :sms_notification_event
end
