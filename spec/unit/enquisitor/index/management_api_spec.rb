# frozen_string_literal: true

RSpec.describe Enquisitor::Index do
  include_context "index helper"

  describe "#create" do
    let(:index_name) { "test_index" }
    subject { index_class.new.create }

    context "when name is not defined" do
      let(:index_name) { nil }

      it "raises an error" do
        expect { subject }.to raise_error %(You must set "name" attribute of the index.)
      end
    end

    context "when index already exists" do
      before do
        allow(indices_client).to receive(:get).with(index: "test_index", ignore_unavailable: true).and_return(
          "test_index_1234" => { "aliases" => { "test_index" => {} } }
        )
      end

      it "raises an error" do
        expect { subject }.to raise_error "Index test_index already exists!"
      end
    end

    context "when index does not exist" do
      before do
        allow(indices_client).to receive(:get).with(index: "test_index", ignore_unavailable: true).and_return({})
      end

      after { subject }

      it "creates aliased index" do
        expect(indices_client).to receive(:create).with(
          index: /\Atest_index_\d{14}\z/,
          body: {
            index: {
              number_of_shards: nil,
              number_of_replicas: nil
            },
            aliases: {
              "test_index" => {}
            }
          }
        )
      end
    end
  end
end
