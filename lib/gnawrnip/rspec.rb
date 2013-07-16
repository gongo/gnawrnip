require 'rspec'

RSpec.configure do |config|
  config.before(:all) do
    Gnawrnip.ready!
  end

  config.before(:each, turnip: true) do
    Gnawrnip.photographer.reset!
    example.metadata[:gnawrnip] = {}
  end

  config.after(:each, turnip: true) do
    if example.exception
      Gnawrnip.photographer.take_shot
      screenshots = Gnawrnip.photographer.frames.compact
      example.metadata[:gnawrnip][:screenshot] = screenshots
    else
      Gnawrnip.photographer.discard!
    end
  end
end
