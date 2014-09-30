require 'capybara/session'

module Capybara
  class Session
    SAVE_SCREENSHOT_METHODS = [
      :click_button,
      :click_link,
      :click_link_or_button,
      :click_on,
      :fill_in,
      :choose,
      :check,
      :uncheck,
      :select,
      :unselect,
      :attach_file,
      :execute_script,
      :go_back,
      :go_forward,
      :switch_to_window,
      :visit
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
