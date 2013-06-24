require 'capybara/session'

module Capybara
  class Session
    SAVE_SCREENSHOT_METHODS = [
      :attach_file, :check, :choose, :click_link_or_button, :click_button,
      :click_link, :fill_in, :select, :uncheck, :unselect, :click_on,
      :evaluate_script, :visit
    ]

    # SAVE_SCREENSHOT_METHODS.each do |method|
    #   alias_method "after_hook_#{method}".to_sym, method
    #
    #   define_method method do |*args, &block|
    #     send("after_hook_#{method}", *args, &block)
    #     Gnawrnip::Animation.add_frame
    #   end
    # end
  end
end
