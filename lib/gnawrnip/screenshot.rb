require 'time'
require 'capybara'
require 'securerandom'
require 'fileutils'

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
      # @return  [String]  Image filename of screenshot
      #
      def take(wait_second = Capybara.default_wait_time)
        start_time = Time.now

        begin
          shot
        rescue Capybara::NotSupportedByDriverError => e
          raise e
        rescue => e
          if (Time.now - start_time) < wait_second
            sleep(0.3)
            retry
          end

          $stderr.puts "WARNING: Timeout!! Can't take screenshot"
          $stderr.puts "  #{e}"

          nil
        end
      end

      def session
        Capybara.current_session
      end

      #
      # @return [Gnawrnip::Image]
      #
      def shot
        path = filepath

        FileUtils.touch(path)
        session.save_screenshot(path)

        path
      end

      def filepath
        SCREENSHOT_OUTPUT_DIR + '/gnawrnip-' + SecureRandom.uuid + '.png'
      end
    end
  end
end
