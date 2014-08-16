require 'gnawrnip/developer'
require 'base64'

module Gnawrnip
  class Publisher

    #
    # @params [Array] filepaths  Array of image filepath
    #
    def animation(filepaths)
      filepaths.map { |path| image_tag(path) }.join
    end

    #
    # @params [String]  filepath image filepath
    #
    def single(filepath)
      image_tag(filepath)
    end

    private

      def image_tag(filepath, format = :png)
        image = Developer.new.develop(filepath)

        width  = image.width
        height = image.height
        data   = image.to_base64

        %Q|<img width="#{width}" height="#{height}" src="data:image/#{format.to_s};base64,#{data}"/>|
      end
  end
end
