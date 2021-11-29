# frozen_string_literal: true

module MyTado
  module Request
    # Calls the /state endpoint, which returns 1 key called presence
    class Presence < AbstractRequest
      def endpoint
        "/v2/homes/#{options[:home_id]}/state"
      end
    end
  end
end
