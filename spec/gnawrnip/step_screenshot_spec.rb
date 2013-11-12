require 'spec_helper'
require 'gnawrnip/step_screenshot'

module Gnawrnip
  describe StepScreenshot do
    let(:template) { StepScreenshot }

    it 'exists failure step template' do
      expect(TurnipFormatter::Step::Failure.templates).to have_key template
    end

    describe '.build' do
      subject { template.build(data_list) }

      context 'has multiple data' do
        let(:data_list) do
          [
            GnawrnipTest.image('aiueo'),
            GnawrnipTest.image('12345'),
            GnawrnipTest.image('abcde')
          ]
        end

        it 'should get image tag and source that base64 encoded' do
          data1 = Base64.strict_encode64('aiueo')
          data2 = Base64.strict_encode64('12345')
          data3 = Base64.strict_encode64('abcde')
          should include '<div class="screenshot animation">'
          should include '<img src="data:image/png;base64,' + data1 + '"/>'
          should include '<img src="data:image/png;base64,' + data2 + '"/>'
          should include '<img src="data:image/png;base64,' + data3 + '"/>'
          should include '<div class="nav">'
        end
      end

      context 'has single data' do
        let(:data_list) { [GnawrnipTest.image('aiueo')] }
        it {
          data = Base64.strict_encode64('aiueo')
          should include '<div class="screenshot">'
          should include '<img src="data:image/png;base64,' + data + '"/></div>'
          should_not include '<div class="nav">'
        }
      end

      context 'has no data' do
        let(:data_list) { [] }
        it { should eq '' }
      end
    end
  end
end
