require 'rspec'
require 'tempfile'
require 'base64'

RSpec.configure do |config|
  config.before(:each, turnip: true) do
    Gnawrnip::Animation.reset!
  end

  config.after(:each, turnip: true) do
    if example.exception
      example.metadata[:gnawrnip] = {}

      # example.metadata[:gnawrnip][:screenshot] = Gnawrnip::Animation.generate
      image = Gnawrnip::Screenshot.take
      example.metadata[:gnawrnip][:screenshot] = Base64.encode64(image.read)
    end
  end
end
