# frozen_string_literal: true

require 'forwardable'

module MyTado
  module Response
    # Make response a bit easier to deal with in Ruby
    class AbstractResponse
      attr_reader :raw_response

      extend Forwardable

      def_delegators :@parsed_response, :[]

      def initialize(raw_response)
        @raw_response = raw_response
        parse
      end

      def ok?
        raw_response.ok?
      end

      def parse
        @parsed_response = recursive_parse(raw_response)
      end

      private

      def recursive_parse(original)
        original.transform_values do |value|
          if value.is_a?(Hash)
            recursive_parse(value)
          elsif iso8601_string?(value)
            Date.parse(value)
          else
            value
          end
        end
      end

      # Try to identify dates, which Tado's API always sends in a consistent format
      def iso8601_string?(value)
        value.is_a?(String) &&
          value.length == 24 &&
          /[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}/.match(value)
      end
    end
  end
end
