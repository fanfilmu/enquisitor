# frozen_string_literal: true

module Enquisitor
  # Index represents Elasticsearch index. It contains all configuration for it (types, mappings, aliases etc.)
  class Index
    extend Forwardable
    extend Mixins::Configurable.new %i[name number_of_shards number_of_replicas]

    # Retrieves or configures per-index connection.
    # If no block is given, it returns connection. If you pass block to the method, it will yield configuration
    # of new connection - with default settings identical to the settings of base Enquisitor::Connection
    def self.connection
      if block_given?
        @connection = Class.new(Connection).tap { |connection| yield connection.configuration }
      else
        @connection ||= Connection.instance
      end
    end

    delegate %i[connection configuration] => "self.class"

    include ManagementAPI
  end
end
