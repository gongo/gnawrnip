require 'turnip/rspec'
require 'turnip_formatter'
require 'rspec/expectations'
require 'capybara'
require 'turnip/capybara'
require 'capybara/poltergeist'
require 'selenium-webdriver'
require 'gnawrnip'

# Load turnip steps
Dir.glob(File.dirname(__FILE__) + "/steps/**/*steps.rb") { |f| load f, true }

RSpec.configure do |config|
  config.add_formatter RSpecTurnipFormatter, 'report.html'
  config.add_formatter 'progress'
end

require_relative '../web'
Capybara.app = Sinatra::Application.new
Capybara.default_driver = :poltergeist
Capybara.javascript_driver = :selenium

Gnawrnip.configure do |c|
  c.publisher_driver = :js
  c.frame_interval = 1000 # milliseconds
  c.frame_size = [640, 360] # width, height
  c.make_animation = true
end
