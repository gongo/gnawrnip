require 'turnip_formatter/step_template/base'
require 'gnawrnip/developer'

module Gnawrnip
  class StepScreenshot < TurnipFormatter::StepTemplate::Base
    on_failed :build

    def self.css
      File.read(File.dirname(__FILE__) + '/gnawrnip.css')
    end

    #
    # @param  [TurnipFormatter::Resource::Step::Failure]  step
    #
    def build(step)
      images = step.example.metadata[:gnawrnip][:screenshot]

      case images.length
      when 0
        ''
      when 1
        single_image(images.first)
      else
        animation_image(images)
      end
    end

    private

    def animation_image(paths)
      text = <<-EOS
          <div class="screenshot animation">
              <div class="nav">
                  <div class="pager"></div>
                  <div class="manipulate">
                      <i class="fa fa-2x fa-step-backward prev"></i>
                      <i class="fa fa-2x fa-play play"></i>
                      <i class="fa fa-2x fa-pause pause"></i>
                      <i class="fa fa-2x fa-step-forward next"></i>
                  </div>
              </div>
              <div class="slides">
        EOS
      text += develop(paths)
      text + <<-EOS
              </div>
          </div>
        EOS
    end

    def single_image(file)
      text = '<div class="screenshot">'
      text += develop([file])
      text + '</div>'
    end

    def develop(files)
      files.map do |file|
        image = developer.develop(file.path)
        image.to_html
      end.join
    end

    def developer
      @developer ||= Developer.new
    end
  end
end

TurnipFormatter.configure do |c|
  c.add_javascript('https://cdnjs.cloudflare.com/ajax/libs/jquery.cycle2/20130801/jquery.cycle2.min.js')
  c.add_stylesheet('https://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css')

  c.add_javascript(File.dirname(__FILE__) + '/gnawrnip.js')
end
