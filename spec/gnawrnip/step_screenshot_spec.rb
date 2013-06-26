require 'spec_helper'
require 'gnawrnip/step_screenshot'

module Gnawrnip
  describe StepScreenshot do
    let :template do
      StepScreenshot
    end

    it 'exists failure step template' do
      expect(TurnipFormatter::Step::Failure.templates).to have_key template
    end

    describe '.build' do
      subject { template.build(data_list) }

      context 'has multiple data' do
        let(:data_list) { ['aiueo', '12345', 'abcde'] }
        it {
          should include '<div class="screenshot animation">'
          should include '<img src="data:image/png;base64,aiueo"/>'
          should include '<img src="data:image/png;base64,12345"/>'
          should include '<img src="data:image/png;base64,abcde"/></div>'
        }
      end

      context 'has single data' do
        let(:data_list) { ['aiueo'] }
        it {
          should include '<div class="screenshot">'
          should include '<img src="data:image/png;base64,aiueo"/></div>'
        }
      end

      context 'has no data' do
        let(:data_list) { [] }
        it {
          should include '<div class="screenshot">'
          should include '<img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAhQ'
        }
      end
    end
  end
end
