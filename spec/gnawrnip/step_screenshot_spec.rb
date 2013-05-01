require 'spec_helper'
require 'gnawrnip/step_screenshot'

module Gnawrnip
  describe StepScreenshot do
    let :template do
      StepScreenshot
    end

    it 'exists failure step template' do
      expect(TurnipFormatter::Step::Failure.templates).to have_key :screenshot
    end

    describe '.build' do
      subject { template.build('aiueo') }
      it { should match %r{<img src="data:image/png;base64,aiueo"} }
    end
  end
end
