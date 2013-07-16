require 'spec_helper'
require 'gnawrnip/publisher/rmagick'
require 'RMagick'

module Gnawrnip
  module Publisher
    describe RMagick do
      let(:photographer) { RMagick.new }

      describe '.new' do
        subject { lambda { photographer } }

        context 'cannot load rmagick' do
          before do
            error = LoadError.new("LoadError: cannot load such file -- RMagick")
            Kernel.stub(:require).and_raise(error)
          end

          it { should raise_error LoadError, /gem 'rmagick'/ }
        end

        context 'cannot load other library' do
          before do
            error = LoadError.new("LoadError: cannot load such file -- samurai")
            Kernel.stub(:require).and_raise(error)
          end

          it { should raise_error LoadError, /such file -- samurai/ }
        end
      end

      describe '#animation' do
        let(:screenshot_list) {
          [GnawrnipTest.image('hoge'), GnawrnipTest.image('fuga')]
        }

        let(:creator) {
          d = double
          d.stub(:write) { |path| File.write(path, d.data) }
          d
        }

        context 'exists image files' do
          before do
            photographer.stub(:photo_creator) do |args|
              creator.stub(:data).and_return(args.map(&:read).join)
            end.and_return(creator)
          end

          subject { photographer.animation(screenshot_list) }
          it { should eq '<img src="data:image/gif;base64,aG9nZWZ1Z2E="/>' }
        end
      end
    end
  end
end
