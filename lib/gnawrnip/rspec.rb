require 'rspec'
require 'tempfile'
require 'base64'

RSpec.configure do |config|
  config.after do
    if example.exception
      temp = Tempfile.new(['gnawrnip', '.png'])
      save_screenshot(temp.path)
      example.metadata[:turnip] ||= {}
      example.metadata[:turnip][:screenshot] = Base64.encode64(File.read(temp.path))
      temp.close!
    end
  end
end
