require 'gnawrnip/screenshot'

module Gnawrnip
  class Photographer
    def take_shot
      frames << Screenshot.take
    end

    def reset!
      frames.clear
    end

    def frames
      @frames ||= []
    end
  end
end
