# frozen_string_literal: true

require 'httparty'

module MyTado
  # The main object from where everything else happens
  class Client
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
      @home_id ||= credentials.home_id
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
  end
end
