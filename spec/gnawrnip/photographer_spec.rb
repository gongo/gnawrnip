require 'spec_helper'
require 'gnawrnip/photographer'

module Gnawrnip
  describe Photographer do
    let(:photographer) do
      Photographer.new
    end

    before do
      photographer.reset!
      photographer.take_shot
      photographer.take_shot
    end

    describe '.add_frame' do
      subject { photographer.frames }
      it { should have(2).elements }
    end

    describe '.reset!' do
      before { photographer.reset! }
      subject { photographer.frames }
      it { should be_empty }
    end
  end
end
