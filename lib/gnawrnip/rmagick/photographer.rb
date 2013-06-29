require 'gnawrnip/photographer'

module Gnawrnip::RMagick
  class Photographer
    include Gnawrnip::Photographer

    def initialize
      Kernel.require 'RMagick'
    rescue LoadError => e
      if e.message =~ /cannot load.*RMagick/
        raise LoadError, "Please install the gem and add `gem 'rmagick'` to your Gemfile if you are using bundler."
      else
        raise e
      end
    end

    def animation(images)
      creator = photo_creator(images)
      tempfile = Tempfile.new(['gnawrnip', '.gif'])
      creator.write(tempfile.path)

      image_tag(image_base64(tempfile.path), :gif)
    end

    def single(image)
      animation([image])
    end

    def photo_creator(images)
      paths = images.map(&:path)
      photos = ::Magick::ImageList.new(*paths)

      photos.delay = Gnawrnip.frame_interval / 10.0
      unless Gnawrnip.frame_size.nil?
        photos.each do |p|
          p.scale!(*Gnawrnip.frame_size)
        end
      end

      photos
    end
  end
end
