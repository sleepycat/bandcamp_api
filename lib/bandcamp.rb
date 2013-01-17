require "bandcamp/request"
require "bandcamp/getter"
require "bandcamp/track"
require "bandcamp/configuration"
require "bandcamp/version"

module BandCamp

  def self.config
    @configuration ||= Configuration.new
  end

  def self.get
    @getter ||= Getter.new(config.api_key)
  end

  def self.search params
    puts params.map{|k,v| "&#{Rack::Utils.escape(k.to_s)}=#{v}"}.join
  end
end

