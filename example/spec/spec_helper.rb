require 'turnip/rspec'
require 'turnip_formatter'
require 'rspec/expectations'
require 'capybara'
require 'turnip/capybara'
require 'gnawrnip'
require 'capybara/poltergeist'

# Load turnip steps
Dir.glob(File.dirname(__FILE__) + "/steps/**/*steps.rb") { |f| load f, true }

RSpec.configure do |config|
  config.add_formatter RSpecTurnipFormatter, 'report.html'
  config.add_formatter 'progress'
end

require_relative '../web'
Capybara.app = Sinatra::Application.new
Capybara.default_driver = :poltergeist
