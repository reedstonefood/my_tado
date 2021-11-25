# frozen_string_literal: true

require_relative "my_tado/client"
require_relative "my_tado/credential_getter"
require_relative "my_tado/oauth_client"
require_relative "my_tado/version"

# Caling `new` creates a Client
module MyTado
  class Error < StandardError; end

  def self.new(...)
    Client.new(...)
  end
end
