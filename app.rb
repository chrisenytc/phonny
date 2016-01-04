# encoding: utf-8

require 'sinatra'
require 'sinatra/json'
require 'twilio-ruby'
require_relative 'config/init'

# Define application
class PhonnyApplication < Sinatra::Application

	use Rack::Deflater

	if ENV['RACK_ENV'] == 'production' then

		use Rack::TwilioWebhookAuthentication, Config.twilio_auth_token,
			'/voice',
			'/voice/handler',
			'/sms',
			'/sms/handler',
			'/sms/callback'

	end

	before do
		content_type 'text/xml'
	end

	configure do
		set :logging, true
	end

  configure :production do
    #set :clean_trace, true
  end

  configure :development do
    set :show_exceptions, true
  end

	not_found do
		status 404

		response = Twilio::TwiML::Response.new do |r|
			r.Say 'Resource not found.'
		end
		
		response.text
	end

	error 403 do
		response = Twilio::TwiML::Response.new do |r|
			r.Say 'Bad Authentication. You do not have permission to access the API!'
		end
	end

	error do
		if ENV['RACK_ENV'] == 'production' then
			response = Twilio::TwiML::Response.new do |r|
				r.Say 'An error has occurred.'
			end
		else
			# Log error
			puts ENV['sinatra.error']
			# Response
			response = Twilio::TwiML::Response.new do |r|
				r.Say ENV['sinatra.error'].message
			end
		end

		response.text
	end

end

# Load endpoints
require_relative 'endpoints/init'
