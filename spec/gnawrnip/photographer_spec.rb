require 'spec_helper'
require 'gnawrnip/photographer'

module Gnawrnip
  describe Photographer do
    let(:photographer) { described_class.new }

    before do
      allow(Screenshot).to receive(:take).and_return('foo')
      photographer.reset!
      photographer.take_shot
      photographer.take_shot
    end

    describe '.add_frame' do
      subject { photographer.frames.length }
      it { should eq 2 }
    end

    describe '.reset!' do
      before { photographer.reset! }
      subject { photographer.frames }
      it { should be_empty }
    end
  end
end
