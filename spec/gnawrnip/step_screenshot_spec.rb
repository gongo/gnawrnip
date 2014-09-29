require 'spec_helper'
require 'gnawrnip/step_screenshot'

module Gnawrnip
  describe StepScreenshot do
    let(:template) { described_class.new }

    describe '.build' do
      before :each do
        allow(template).to receive(:develop).and_return('')
      end

      let(:example) do
        metadata = { gnawrnip: { screenshot: paths } }
        double('example', metadata: metadata)
      end

      subject { template.build(example) }

      context 'has multiple data' do
        let(:paths) do
          [
            double(path: '/path/to/A.png'),
            double(path: '/path/to/B.png'),
            double(path: '/path/to/C.png')
          ]
        end

        it 'should get image tag and source that base64 encoded' do
          should include '<div class="screenshot animation">'
          should include '<div class="nav">'
        end
      end

      context 'has single data' do
        let(:paths) { [double(path: '/path/to/A.png')] }
        it do
          should include '<div class="screenshot">'
          should_not include '<div class="nav">'
        end
      end

      context 'has no data' do
        let(:paths) { [] }
        it { should eq '' }
      end
    end
  end
end
