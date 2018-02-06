# frozen_string_literal: true

RSpec.shared_context "index helper" do
  let(:index_class) do
    index_name = send("index_name")

    Class.new(described_class) do
      configure do |config|
        config.name = index_name
      end
    end
  end

  let(:client)         { instance_double(Elasticsearch::Transport::Client, indices: indices_client) }
  let(:indices_client) { instance_double(Elasticsearch::API::Indices::IndicesClient) }

  before { allow(Enquisitor::Connection.instance).to receive(:client).and_return(client) }
end
