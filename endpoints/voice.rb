# encoding: utf-8
# frozen_string_literal: true

class PhonnyApplication < Sinatra::Application
  post '/voice' do
    from = /^client/ =~ params['From'] ? nil : params['From']

    response = Twilio::TwiML::Response.new do |r|
      r.Dial callerId: from, timeout: 120, record: true, action: '/voice/handler' do |d|
        d.Number Config.phone_number
      end
    end

    response.text
  end

  post '/voice/handler' do
    status = params['DialCallStatus']
    id = params['DialCallSid']
    duration = params['DialCallDuration']
    voice_url = params['RecordingUrl']

    puts "ID => #{id} => Call duration => #{duration} => Status => #{status}"
    puts "Voice record => #{voice_url}" if voice_url

    response = Twilio::TwiML::Response.new do |r|
      r.Say 'Goodbye.', voice: 'alice', language: 'en-GB'
    end

    response.text
  end
end
