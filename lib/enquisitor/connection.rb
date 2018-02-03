# frozen_string_literal: true

module Enquisitor
  # This is a Singleton class which holds connection to Elasticsearch cluster.
  class Connection
    include Singleton

    extend Mixins::Configurable.new %i[
      url host hosts randomize_hosts
      log trace logger tracer
      resurrect_after sniffer_timeout request_timeout
      reload_connections reload_on_failure
      retry_on_failure retry_on_status
      transport_options send_get_body_as
    ]

    def self.inherited(subclass)
      subclass.instance_variable_set("@configuration", configuration.dup)
      super
    end

    def client
      @client ||= Elasticsearch::Client.new(self.class.configuration.to_h.compact)
    end

    private

    # Once connection is instantiated, changing configuration is not possible
    def initialize
      self.class.configuration.freeze
    end
  end
end
