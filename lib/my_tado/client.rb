# frozen_string_literal: true

require 'httparty'

module MyTado
  # The main object from where everything else happens
  class Client
    IMPLEMENTED_ENDPOINTS = %i[me day_report home presence weather zones zone_state].freeze

    def initialize(credentials_source)
      @credentials_source = credentials_source
    end

    def credentials
      @credentials ||= CredentialGetter.new(@credentials_source)
    end

    def access_token
      oauth_client.access_token
    end

    def home_id
      @home_id ||= credentials.home_id || me["homeId"]
    end

    IMPLEMENTED_ENDPOINTS.each do |endpoint|
      define_method endpoint.to_s do |options = {}|
        klass = Object.const_get("MyTado::Request::#{camelize(endpoint)}")
        options.merge!(home_id: home_id) if klass.requires_home_id_param?
        request = klass.new(access_token, options)
        Response::AbstractResponse.new(request.call)
      end
    end

    private

    def oauth_client
      return @oauth_client if defined?(@oauth_client)

      @oauth_client = OAuthClient.new(
        client_secret: credentials.client_secret,
        username: credentials.username,
        password: credentials.password,
      )
    end

    def camelize(string)
      string.to_s.split('_').collect(&:capitalize).join
    end
  end
end
