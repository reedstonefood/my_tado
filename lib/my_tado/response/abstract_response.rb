# frozen_string_literal: true

require 'forwardable'

module MyTado
  module Response
    # Make response a bit easier to deal with in Ruby, largely by
    # converting datetimes to Ruby DateTime objects
    class AbstractResponse
      attr_reader :raw_response

      def initialize(raw_response)
        @raw_response = raw_response
        parse
      end

      def ok?
        raw_response.ok?
      end

      def parse
        @parsed_response = recursive_parse(raw_response.parsed_response)
      end

      def method_missing(method_name, *args, &block)
        if @parsed_response.respond_to?(method_name)
          @parsed_response.public_send(method_name, *args, &block)
        else
          super
        end
      end

      def respond_to_missing?(method_name, *_args)
        @parsed_response.respond_to?(method_name)
      end

      private

      def recursive_parse(original)
        case original
        when Hash
          original.transform_values do |value|
            clever_parse(value)
          end
        when Array
          original.map do |value|
            clever_parse(value)
          end
        end
      end

      def clever_parse(value)
        if value.is_a?(Hash) || value.is_a?(Array)
          recursive_parse(value)
        elsif iso8601_string?(value)
          DateTime.parse(value)
        else
          value
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
