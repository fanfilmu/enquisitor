# frozen_string_literal: true

module Enquisitor
  module Mixins
    # Mixin for configurable objects. Provides .configuration and .configure methods.
    # usage:
    #
    #   extend Mixins::Configurable.new %i[config_param1 config_param2]
    class Configurable < Module
      def initialize(parameters)
        struct_type = Struct.new(*parameters)

        super() do
          define_method(:configuration) { @configuration ||= struct_type.new }
          define_method(:configure) { |&block| configuration.tap { |config| block.call(config) } }
        end
      end
    end
  end
end
