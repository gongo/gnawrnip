require 'spec_helper'
require 'gnawrnip/step_screenshot'

module Gnawrnip
  describe StepScreenshot do
    let(:template) { described_class.new }

    describe '.build' do
      let(:example) do
        metadata = { gnawrnip: { screenshot: data_list } }
        double('example', metadata: metadata)
      end

      subject { template.build(example) }

      context 'has multiple data' do
        let(:data_list) do
          [
            double(to_base64: 'aiueo', width: 640, height: 480),
            double(to_base64: '12345', width: 512, height: 200),
            double(to_base64: 'abcde', width: 640, height: 320)
          ]
        end

        it 'should get image tag and source that base64 encoded' do
          should include '<div class="screenshot animation">'
          should include '<img width="640" height="480" src="data:image/png;base64,aiueo"/>'
          should include '<img width="512" height="200" src="data:image/png;base64,12345"/>'
          should include '<img width="640" height="320" src="data:image/png;base64,abcde"/>'
          should include '<div class="nav">'
        end
      end

      context 'has single data' do
        let(:data_list) { [ double(to_base64: 'abcde', width: 640, height: 480) ] }
        it {
          should include '<div class="screenshot">'
          should include '<img width="640" height="480" src="data:image/png;base64,abcde"/></div>'
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
