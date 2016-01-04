# encoding: utf-8

class Config

	def self.twilio_auth_token
		ENV['TWILIO_AUTH_TOKEN']
	end

	def self.phone_number
		ENV['PHONE_NUMBER']
	end

end

