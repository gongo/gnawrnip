require 'oily_png'

module Gnawrnip
  class Image
    #
    # @parma [File] Screenshot image file (png)
    #
    def initialize(file)
      @file = file
      analysis
    end

    #
    # @return [Fixnum] Width of image
    #
    def width
      @dimension.width
    end

    #
    # @return [Fixnum] Height of image
    #
    def height
      @dimension.height
    end

    def to_base64
      Base64.strict_encode64(File.read(@file.path))
    end

    def resize(width, height)
      canvas.resample_bilinear(width, height).save(@file.path)
      analysis
    end

    def close!
      @file.close!
    end

    private

      #
      # Update dimension (OilyPNG::Dimension) of Image
      #
      def analysis
        @dimension = canvas.dimension
      end

      def canvas
        OilyPNG::Canvas.from_file(@file)
      end
  end
end
