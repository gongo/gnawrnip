require 'time'
require 'capybara'
require 'tempfile'

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
      # @param   [Fixnum]  wait_second  Second to repeat the retry
      # @return  [Tempfile]  Image file of screenshot
      #
      def take(wait_second = Capybara.default_max_wait_time)
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
      # @return [Tempfile]
      #
      def shot
        Tempfile.open(['gnawrnip', '.png']) do |fp|
          session.save_screenshot(fp.path)
          fp
        end
      end
    end
  end
end
