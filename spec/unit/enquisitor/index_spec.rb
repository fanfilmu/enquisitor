# frozen_string_literal: true

RSpec.describe Enquisitor::Index do
  describe ".connection" do
    subject { described_class.connection }

    context "when not configured" do
      it "returns default connection" do
        is_expected.to eq Enquisitor::Connection.instance
      end
    end

    context "when is supplied with additional configuration" do
      subject do
        described_class.connection do |config|
          config.url = "http://localhost:10200"
        end
      end

      it "returns new configuration" do
        expect(subject).to_not eq Enquisitor::Connection.instance
      end

      it { expect(subject.instance).to be_a_kind_of(Enquisitor::Connection) }

      it "has different settings" do
        expect(subject.configuration.url).to eq "http://localhost:10200"
      end
    end
  end
end
