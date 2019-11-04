class User < ApplicationRecord
  after_create :welcome_send

  has_many :events_hosted, foreign_key: 'admin_id', class_name: "Event"
  has_many :attendances
  has_many :events, through: :attendances
  

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end
  
end