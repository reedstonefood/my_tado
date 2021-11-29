# frozen_string_literal: true

module MyTado
  module Request
    # Calls the /weather endpoint
    class Weather < AbstractRequest
      def endpoint
        "/v2/homes/#{options[:home_id]}/weather"
      end
    end
  end
end
