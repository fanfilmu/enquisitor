# frozen_string_literal: true

RSpec.describe Enquisitor::Connection do
  before do
    described_class.configure do |config|
      config.url = "http://localhost:10200"
      config.log = true
    end
  end

  after do
    Singleton.__init__(described_class)
    described_class.instance_variable_set("@configuration", nil)
  end

  describe ".configure" do
    it { expect(described_class.configuration).to have_attributes(url: "http://localhost:10200", log: true) }
  end

  describe ".inherited" do
    let(:inheriting_class) { Class.new(described_class) }

    it { expect(inheriting_class.configuration).to have_attributes(url: "http://localhost:10200", log: true) }
  end

  describe "#client" do
    subject { described_class.instance.client }

    it { is_expected.to be_a(Elasticsearch::Transport::Client) }

    it "passes proper option to created Elasticsearch client" do
      expect(Elasticsearch::Client).to receive(:new).with(url: "http://localhost:10200", log: true)
      subject
    end

    it "freezes configuration" do
      expect { subject }.to change { described_class.configuration.frozen? }.to(true)
    end
  end
end
