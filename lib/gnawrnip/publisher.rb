require 'base64'

module Gnawrnip
  class Publisher

    #
    # @params [Array]  images  Array of Gnawrnip::Image
    #
    def animation(images)
      images.map { |image| image_tag(image) }.join
    end

    #
    # @params [Gnawrnip::Image]  image
    #
    def single(image)
      image_tag(image)
    end

    private

      def image_tag(image, format = :png)
        width  = image.width
        height = image.height
        data   = image.to_base64
        %Q|<img width="#{width}" height="#{height}" src="data:image/#{format.to_s};base64,#{data}"/>|
      end
  end
end
