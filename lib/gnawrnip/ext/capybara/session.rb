require 'capybara/session'

module Capybara
  class Session
    SAVE_SCREENSHOT_METHODS = NODE_METHODS + [
      :visit, :has_title?, :has_no_title?, :go_back, :go_forward
    ]

    SAVE_SCREENSHOT_METHODS.each do |method|
      alias_method "after_hook_#{method}".to_sym, method

      define_method method do |*args, &block|
        Gnawrnip.photographer.take_shot
        send("after_hook_#{method}", *args, &block)
      end
    end
  end
end
