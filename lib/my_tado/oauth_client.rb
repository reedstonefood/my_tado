# frozen_string_literal: true

require 'httparty'

module MyTado
  # Gets the authorization credentials we need to interact with the main API
  class OAuthClient
    class NoCredentialsError < StandardError; end
    include HTTParty
    base_uri "https://auth.tado.com/oauth"

    def initialize(client_secret:, username:, password:)
      @default_options = { client_id: "tado-web-app", scope: "home.user", client_secret: client_secret }
      @refresh_token = nil
      @username = username
      @password = password
    end

    # Doesn't cache it or do anything clever yet
    def access_token(preferred_method: "refresh")
      if preferred_method == "refresh" && @refresh_token
        using_refresh_token["access_token"]
      elsif @username && @password
        using_username_and_password["access_token"]
      else
        raise NoCredentialsError
      end
    end

    def using_refresh_token
      response = self.class.post(
        "/token",
        options({
          grant_type: "refresh_token",
          refresh_token: @refresh_token,
        }),
      )

      @refresh_token = response["refresh_token"]
      response
    end

    def using_username_and_password
      response = self.class.post(
        "/token",
        options({
          grant_type: "password",
          username: @username,
          password: @password,
        }),
      )

      @refresh_token = response["refresh_token"]
      response
    end

    private

    def options(extra_options)
      { body: @default_options.merge(extra_options) }
    end
  end
end
