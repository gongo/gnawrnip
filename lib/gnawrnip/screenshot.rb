require 'tempfile'
require 'time'
require 'capybara'
require 'oily_png'

module Gnawrnip
  class Screenshot
    class << self

      #
      # Screenshot of current capybara session
      #
      # When browser is still loading page, raise follow exception (maybe...)
      #
      #   Selenium::WebDriver::Error::UnknownError:
      #     Could not take screenshot of current page - TypeError: c is null
      #
      # So, to retry during +wait_second+ seconds.
      #
      # @example
      #   image = Gnawrnip::Screenshot.take
      #
      #
      # @param   [Fixnum]  wait_second  Second to repeat the retry
      # @return  [Tempfile]  Image file of screenshot
      #
      def take(wait_second = Capybara.default_wait_time)
        start_time = Time.now

        begin
          tempfile = Tempfile.new(['gnawrnip', '.png'])
          session.save_screenshot(tempfile.path)
          resize(tempfile.path) if need_resize?
          tempfile
        rescue Capybara::NotSupportedByDriverError => e
          raise e
        rescue => e
          raise e if (Time.now - start_time) >= wait_second
          sleep(0.3)
          retry
        end
      end

      private

        def session
          Capybara.current_session
        end

        def need_resize?
          !Gnawrnip.max_frame_size.nil?
        end

        def resize(path)
          image = OilyPNG::Canvas.from_file(path)
          new_width, new_height = calculate_new_size(image.width, image.height)

          image.resample_bilinear!(new_width, new_height)
          image.save(path)
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

          return [new_width, new_height]
        end
    end
  end
end
