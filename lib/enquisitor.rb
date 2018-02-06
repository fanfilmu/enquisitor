# frozen_string_literal: true

require "enquisitor/version"

require "elasticsearch"
require "singleton"
require "typhoeus"
require "typhoeus/adapters/faraday"

require "enquisitor/mixins/configurable"

require "enquisitor/connection"
require "enquisitor/index/management_api"
require "enquisitor/index"

# Enquisitor aims to provide easy to use integration with Elasticsearch.
module Enquisitor
end
