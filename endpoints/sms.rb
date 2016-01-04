# encoding: utf-8

class PhonnyApplication < Sinatra::Application

	post '/sms' do
		sender = params['From']
		msg = params['Body']

		response = Twilio::TwiML::Response.new do |r|
			r.Message msg, to: Config.phone_number, from: sender, action: '/sms/handler', statusCallback: '/sms/callback'
		end

		response.text
	end

	post '/sms/handler' do
		status = params['MessageStatus']

		puts "SMS message status => #{status}"

		response = Twilio::TwiML::Response.new do |r|
			r.Message 'Message received'
		end

		response.text
	end

	post '/sms/callback' do
		status = params['MessageStatus']

		puts "SMS message callback status => #{status}"

		response = Twilio::TwiML::Response.new do |r|
			r.Message 'Message received'
		end

		response.text
	end

end

