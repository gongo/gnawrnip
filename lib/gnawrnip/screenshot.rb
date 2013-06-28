require 'tempfile'
require 'capybara'

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
      #
      # @return  [String]  Base64-encoded image of screenshot
      #
      def take(wait_second = Capybara.default_wait_time)
        start_time = Time.now

        begin
          tempfile = Tempfile.new(['gnawrnip', '.png'])
          session.save_screenshot(tempfile.path)
          image = Base64.strict_encode64(tempfile.read)
          tempfile.close
          image
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
    end
  end
end
