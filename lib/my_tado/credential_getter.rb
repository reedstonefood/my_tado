# frozen_string_literal: true

module MyTado
  # Gets credentials from a source, either YAML or a string
  class CredentialGetter
    class InvalidSourceError < StandardError; end
    class HomeIDNotAnIntegerError < StandardError; end
    DEFAULT_CLIENT_SECRET = 'wZaRN7rpjn3FoNyF5IFuxg9uMzYJcvOoQ8QWiIqS3hfk6gLhVlG57j5YNoZL2Rtc'
    require 'yaml'
    attr_reader :data

    def initialize(data_source)
      case data_source.class.to_s
      when "Hash"
        load_hash(data_source)
      when "String"
        load_file(data_source)
      else
        raise InvalidSourceError
      end
    end

    def client_secret
      data["client_secret"] || DEFAULT_CLIENT_SECRET
    end

    def home_id
      data["home_id"]
    end

    def password
      data["password"]
    end

    def refresh_token
      data["refresh_token"]
    end

    def username
      data["username"]
    end

    private

    def load_file(source_file)
      @data = YAML.load_file(source_file)
    end

    def load_hash(hash)
      @data = hash.transform_keys(&:to_s)
      begin
        @data["home_id"] = Integer(@data["home_id"]) if @data["home_id"]
      rescue ArgumentError
        raise HomeIDNotAnIntegerError
      end
    end
  end
end
