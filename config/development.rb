# encoding: utf-8
# frozen_string_literal: true

class Config
  def self.twilio_auth_token
    ENV['TWILIO_AUTH_TOKEN'] || 'enter_your_twilio_token'
  end

  def self.phone_number
    ENV['PHONE_NUMBER'] || 'enter_your_phone_number'
  end
end
