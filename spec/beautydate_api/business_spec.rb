require 'spec_helper'

describe BeautydateApi::Business do
  subject { described_class.new(attributes) }

  before(:all) do
    @response = JSON.load(File.read('./spec/fixtures/business.json'))
  end

  before { BeautydateApi::Core::Request.stub(:request).with('GET', described_class.url(id_or_uuid)) { @response } }


  describe '#refresh' do
    let(:attributes) { { id: id_or_uuid } }

    context 'when id is present' do
      let(:id_or_uuid) { 1 }
      it { expect(subject.refresh).to be_truthy }
      it { expect(subject.tap(&:refresh).attributes).to be_present }
    end

    context 'when uuid is present' do
      let(:id_or_uuid) { SecureRandom.uuid }
      it { expect(subject.refresh).to be_truthy }
      it { expect(subject.tap(&:refresh).attributes).to be_present }
    end

    context 'when neither id nor uuid are present' do
      let(:id_or_uuid) { nil }
      it { expect { subject.refresh }.to raise_error(BeautydateApi::Core::Resource::UnkownIdentifierError) }
    end
  end
end
