# frozen_string_literal: true

module MyTado
  module Request
    # Calls the /me endpoint
    class Me < AbstractRequest
      def self.requires_home_id_param?
        false
      end

      def endpoint
        "/v1/me"
      end
    end
  end
end
