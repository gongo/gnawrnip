require 'capybara/session'

module Capybara
  class Session
    SAVE_SCREENSHOT_METHODS = NODE_METHODS + [
      :visit, :has_title?, :has_no_title?
    ]

    SAVE_SCREENSHOT_METHODS.each do |method|
      alias_method "after_hook_#{method}".to_sym, method

      define_method method do |*args, &block|
        Gnawrnip::Animation.add_frame
        send("after_hook_#{method}", *args, &block)
      end
    end
  end
end
