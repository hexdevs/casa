class SmsNotificationEvent < ApplicationRecord
  has_many :user_sms_notification_events
  has_many :users, through: :user_sms_notification_events
end
