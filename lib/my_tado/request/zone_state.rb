# frozen_string_literal: true

module MyTado
  module Request
    # Calls the /zones/state endpoint
    class ZoneState < AbstractRequest
      def endpoint
        "/v2/homes/#{options[:home_id]}/zones/#{options[:zone_id]}/state"
      end
    end
  end
end
