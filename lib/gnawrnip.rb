require "gnawrnip/version"
require 'gnawrnip/rspec'
require 'gnawrnip/photographer'
require 'gnawrnip/publisher'

module Gnawrnip
  class << self
    attr_accessor :frame_interval
    attr_accessor :frame_size
    attr_accessor :make_animation

    def configure
      yield self
    end

    def ready!
      require 'gnawrnip/ext/capybara/session' if animation?
      require 'gnawrnip/step_screenshot'
    end

    def animation?
      make_animation
    end

    def photographer
      @photographer ||= Photographer.new
    end

    def publisher
      @publisher ||= Publisher.new
    end

    def publisher_driver=(driver)
      warn "DEPRECATED: `publisher_driver` option is deprecated (not used)."
    end
  end
end

Gnawrnip.configure do |c|
  c.frame_interval   = 1000
  c.frame_size       = nil
  c.make_animation   = true
end
