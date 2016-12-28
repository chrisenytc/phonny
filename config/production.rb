# encoding: utf-8
# frozen_string_literal: true

class Config
  def self.twilio_auth_token
    ENV['TWILIO_AUTH_TOKEN']
  end

  def self.twilio_phone_number
    ENV['TWILIO_PHONE_NUMBER']
  end

  def self.phone_number
    ENV['PHONE_NUMBER']
  end
end
