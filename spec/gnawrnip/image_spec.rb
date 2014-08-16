require 'spec_helper'
require 'gnawrnip/image'

module Gnawrnip
  describe Image do
    before do
      allow_any_instance_of(Image).to receive(:canvas).and_return(canvas)
    end

    let(:image) do
      Image.new(GnawrnipTest.image('gnawrnip/image'))
    end

    context 'image size is 640x480' do
      let(:canvas) do
        double(dimension: dimension, save: nil)
      end

      let(:dimension) do
        double(width: 640, height: 480)
      end

      describe '.width' do
        subject { image.width }
        it { should eql 640 }
      end

      describe '.height' do
        subject { image.height }
        it { should eql 480 }
      end

      describe '.resize' do
        let(:canvas) do
          canvas = super()
          expect(canvas).to receive(:resample_bilinear).with(320, 240).and_return(canvas)
          canvas
        end

        before do
          expect_any_instance_of(Image).to receive(:analysis).twice
        end

        it { image.resize(320, 240) }
      end
    end
  end
end
