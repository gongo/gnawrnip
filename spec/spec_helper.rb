require 'tempfile'
require 'capybara'

require 'coveralls'
Coveralls.wear!

require 'gnawrnip'

module GnawrnipTest
  def self.image(data)
    tempfile = Tempfile.new('gnarwnip_test')
    tempfile.write(data)
    tempfile.rewind
    tempfile
  end

  class Session
    def save_screenshot(file_path)
      File.open(file_path, 'w') do |fp|
        fp.print 'screenshot'
      end
    end

    def method_missing(name, *args, &block)
      # nooooooop
    end
  end
end

module Capybara
  def self.current_session
    GnawrnipTest::Session.new
  end
end

require 'rspec/core/sandbox'

RSpec.configure do |c|
  c.around :each do |ex|
    RSpec::Core::Sandbox.sandboxed do |config|
      load 'gnawrnip/rspec.rb'
      ex.run
    end
  end
end
