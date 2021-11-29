# frozen_string_literal: true

module MyTado
  module Request
    # Calls the /home endpoint
    class Zones < AbstractRequest
      def endpoint
        "/v2/homes/#{options[:home_id]}/zones"
      end
    end
  end
end
