# frozen_string_literal: true

require_relative "my_tado/client"
require_relative "my_tado/credential_getter"
require_relative "my_tado/oauth_client"
require_relative "my_tado/version"
require_relative "my_tado/request/abstract_request"
require_relative "my_tado/request/me"
require_relative "my_tado/request/home"
require_relative "my_tado/request/presence"
require_relative "my_tado/request/weather"
require_relative "my_tado/request/zones"
require_relative "my_tado/request/zone_state"
require_relative "my_tado/response/abstract_response"

# Caling `new` creates a Client
module MyTado
  class Error < StandardError; end

  def self.new(...)
    Client.new(...)
  end
end
