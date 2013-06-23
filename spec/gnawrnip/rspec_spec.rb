require 'spec_helper'
require 'gnawrnip/rspec'

module Gnawrnip
  describe 'Rspec' do
    before do
      Gnawrnip::Animation.should_receive(:generate).and_return('aiueo')
    end

    let(:example) do
      example = group.example('example', {}) { expect(true).to be_false }
      group.run(
        Class.new do
          def self.method_missing(name, *args, &block)
            # nooooooop
          end
        end
      )
      example
    end

    context '"turnip" spec group' do
      let(:group) do
        ::RSpec::Core::ExampleGroup.describe('Feature', turnip: true)
      end

      it 'should save screen shot at error' do
        expect(example.metadata[:gnawrnip][:screenshot]).to eq 'aiueo'
      end
    end

    context 'Not "turnip" spec group' do
      let(:group) do
        ::RSpec::Core::ExampleGroup.describe('Feature')
      end

      it 'should not save screen shot' do
        expect(example.metadata).not_to include(:gnawrnip)
      end
    end
  end
end
