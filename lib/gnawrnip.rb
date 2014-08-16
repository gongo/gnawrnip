require "gnawrnip/version"
require 'turnip_formatter'
require 'gnawrnip/rspec'
require 'gnawrnip/photographer'
require 'gnawrnip/publisher'

module Gnawrnip
  class << self
    #
    # [Integer] Time (millisecond) between each image in animation
    #
    attr_accessor :frame_interval_ms

    #
    # [Boolean] Whether to make animation GIF
    #
    attr_accessor :make_animation

    #
    # [Integer] Maximum size that use to resize of image.
    #           If given, it resize the image to fit to this value.
    #           Ignored if this value is greater than original width and height.
    #
    #           Example:
    #                   original: 640x480
    #                 this value: 300
    #                    result : 300x225
    #
    #                   original: 480x640
    #                 this value: 400
    #                    result : 300x400
    #
    attr_accessor :max_frame_size

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
  c.frame_interval_ms = 1000
  c.make_animation    = true
  c.max_frame_size    = nil
end
