require 'rspec'

RSpec.configure do |config|
  config.before(:all) do
    Gnawrnip.ready!
  end

  config.after(:all) do
    Gnawrnip.finish!
  end

  # https://github.com/jnicklas/capybara/blob/master/lib/capybara/rspec.rb
  fetch_current_example = RSpec.respond_to?(:current_example) ?
    proc { RSpec.current_example } : proc { |context| context.example }

  config.before(:each, turnip: true) do
    example = fetch_current_example.call(self)
    Gnawrnip.photographer.reset!
    example.metadata[:gnawrnip] = {}
  end

  config.after(:each, turnip: true) do
    example = fetch_current_example.call(self)

    if example.exception
      Gnawrnip.photographer.take_shot
      screenshots = Gnawrnip.photographer.frames.compact
      example.metadata[:gnawrnip][:screenshot] = screenshots
    else
      Gnawrnip.photographer.discard!
    end
  end
end
