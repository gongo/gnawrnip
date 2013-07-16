require 'gnawrnip/screenshot'

module Gnawrnip
  class Photographer
    def take_shot
      frames << Screenshot.take
    end

    def reset!
      frames.clear
    end

    #
    # Close tempfiles.
    #
    def discard!
      frames.each(&:close!)
      reset!
    end

    def frames
      @frames ||= []
    end
  end
end
