require 'gnawrnip/image'

module Gnawrnip
  class Developer
    def develop(file)
      image = Image.new(file)
      resize(image) if need_resize?
      image
    end

    private

    def resize(image)
      new_width, new_height = calculate_new_size(image.width, image.height)

      return if [new_width, new_height] === [image.width, image.height]

      image.resize(new_width, new_height)
    end

    def need_resize?
      !Gnawrnip.max_frame_size.nil?
    end

    #
    # Return new frame size (width and height).
    # This size is keeping original aspect ratio.
    #
    # @return  [Array]  New width and height size. [width, height]
    #
    def calculate_new_size(width, height)
      ratio  = width.to_f / height.to_f
      target = Gnawrnip.max_frame_size

      return [width, height] if target > [width, height].max

      if ratio < 1
        new_width  = target * ratio
        new_height = target
      else
        new_width  = target
        new_height = target / ratio
      end

      [new_width, new_height]
    end
  end
end
