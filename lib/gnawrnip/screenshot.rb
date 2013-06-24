require 'tempfile'
require 'capybara'

module Gnawrnip
  class Screenshot
    class << self

      #
      # Screenshot of current capybara session
      #
      # @example
      #   image = Gnawrnip::Screenshot.take
      #
      # @return  [String]  Base64-encoded image of screenshot
      #
      def take
        tempfile = Tempfile.new(['gnawrnip', '.png'])
        session.save_screenshot(tempfile.path)
        image = Base64.encode64(tempfile.read)
        tempfile.close
        image
      end

      private

      def session
        Capybara.current_session
      end
    end
  end
end
