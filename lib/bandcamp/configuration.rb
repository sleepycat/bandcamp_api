module BandCamp
  class ConfigurationError < StandardError; end

  class Configuration

    attr_writer :api_key

    def api_key
      raise ConfigurationError, "You need to set an API key" unless @api_key
      @api_key
    end

  end

end
