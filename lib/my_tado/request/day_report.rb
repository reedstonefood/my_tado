# frozen_string_literal: true

module MyTado
  module Request
    # Calls the /dayReport endpoint
    class DayReport < AbstractRequest
      def endpoint
        "/v2/homes/#{options[:home_id]}/zones/#{options[:zone_id]}/dayReport?date=#{formatted_date}"
      end

      def formatted_date
        Date.parse(options[:date]).strftime('%Y-%m-%d')
      end
    end
  end
end
