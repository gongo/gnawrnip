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
      # @return  [Tempfile]  Image of screenshot
      #
      def take
        tempfile = Tempfile.new(['gnawrnip', '.png'])
        session.save_screenshot(tempfile.path)
        tempfile
      end

      private

      def session
        Capybara.current_session
      end
    end
  end
end
