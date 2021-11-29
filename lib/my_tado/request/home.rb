# frozen_string_literal: true

module MyTado
  module Request
    # Calls the /home endpoint
    class Home < AbstractRequest
      def endpoint
        "/v2/homes/#{options[:home_id]}"
      end
    end
  end
end
