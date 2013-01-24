require "bandcamp/request"
require "bandcamp/getter"
require "bandcamp/track"
require "bandcamp/configuration"
require "bandcamp/version"

module Bandcamp

  def self.config
    @configuration ||= Configuration.new
  end

  def self.get
    request
  end

  def self.search band_name
    request.search(band_name)
  end

  def self.resolve
    request
  end

  private

  def self.request
    Getter.new(Request.new config.api_key)
  end

end

