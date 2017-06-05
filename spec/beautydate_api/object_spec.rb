require 'spec_helper'

describe BeautydateApi::Object do
  subject { described_class.new(attributes) }

  context 'when initialized' do
    context 'with id' do
      let(:attributes) { { id: 1 } }

      it { expect(subject.attributes.keys).not_to include(:id) }
      it { expect(subject.id).to eq(1) }
    end

    context 'with any other attribute' do
      let(:attribute)  { 'name' }
      let(:attributes) { { attribute => 'Foobar' } }

      it { expect(subject.attributes.dig(attribute)).to eq(attributes[attribute]) }
      it { expect(subject).to respond_to(attribute) }
      it { expect(subject).to respond_to("#{attribute}=") }

      context 'with a new value set to an attribute' do
        before { subject.name = 'Lorme Ipsum' }

        it 'adds to the list of unsaved attributes'  do
          expect(subject.unsaved_attributes).to include('name')
        end
      end
    end
  end
end
