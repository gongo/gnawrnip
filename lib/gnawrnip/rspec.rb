require 'rspec'

RSpec.configure do |config|
  config.before(:all) do
    Gnawrnip.ready!
  end

  config.before(:each, turnip: true) do
    example = RSpec.current_example
    Gnawrnip.photographer.reset!
    example.metadata[:gnawrnip] = {}
  end

  config.after(:each, turnip: true) do
    example = RSpec.current_example

    if example.exception
      Gnawrnip.photographer.take_shot
      screenshots = Gnawrnip.photographer.frames.compact
      example.metadata[:gnawrnip][:screenshot] = screenshots
    else
      Gnawrnip.photographer.frames.compact.each do |fp|
        fp.close!
      end
    end
  end
end
