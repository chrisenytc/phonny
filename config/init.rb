# encoding: utf-8
# frozen_string_literal: true

environment = ENV['RACK_ENV'] || 'development'

if environment == 'development'
  require_relative 'development'
elsif environment == 'production'
  require_relative 'production'
else
  puts 'No environments!'
end
