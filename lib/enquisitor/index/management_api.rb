# frozen_string_literal: true

module Enquisitor
  class Index
    # This module handles logic for creating, recreating and deleting an index
    module ManagementAPI
      def create
        assert_creatable

        index_name = [configuration.name, Time.now.strftime("%Y%m%d%H%M%S")].join("_")
        connection.client.indices.create(index: index_name, body: creation_body)
      end

      def get(ignore_unavailable: false)
        connection.client.indices.get(index: configuration.name, ignore_unavailable: ignore_unavailable)
      end

      private

      def assert_creatable
        raise %(You must set "name" attribute of the index.) unless configuration.name
        raise "Index #{configuration.name} already exists!" unless get(ignore_unavailable: true) == {}
      end

      def creation_body
        {
          index: {
            number_of_shards: configuration.number_of_shards,
            number_of_replicas: configuration.number_of_replicas
          },
          aliases: {
            configuration.name => {}
          }
        }
      end
    end
  end
end
