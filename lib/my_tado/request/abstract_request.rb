# frozen_string_literal: true

require 'httparty'

module MyTado
  module Request
    # Sends requests to tado's main API
    class AbstractRequest
      include HTTParty
      base_uri "https://my.tado.com/api"
      attr_reader :options

      def self.requires_home_id_param?
        true
      end

      def initialize(access_token, options)
        @access_token = access_token
        @options = options
      end

      def call
        self.class.public_send(method, endpoint, {
          headers: { "Authorization" => "Bearer #{@access_token}" },
          body: body,
        },)
      end

      def method
        :get
      end

      def klass_name
        self.class.to_s.gsub(/(.)([A-Z])/, '\1_\2').downcase
      end

      def body
        nil
      end
    end
  end
end
