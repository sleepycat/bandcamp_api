module BandCamp
  class ConfigurationError < StandardError; end

  class Configuration

    attr_writer :api_key

    def initialize
      @api_key ||= ""
      @uri = "http://api.bandcamp.com"
    end

    def api_key
      raise ConfigurationError, "You need to set an API key" unless @api_key
      @api_key
    end

  end

end
