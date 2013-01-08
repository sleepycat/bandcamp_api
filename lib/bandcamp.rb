require 'multi_json'
require 'open-uri'
require "bandcamp/request"
require "bandcamp/track"
require "bandcamp/configuration"
require "bandcamp/version"

module BandCamp

  def self.config
    @configuration ||= Configuration.new
  end

  def self.find_by_url url
    api_url = "http://api.bandcamp.com/api/url/2/info?key=#{config.api_key}&url=#{url}"
    puts api_url
    info = MultiJson.decode(open(api_url))
    puts info
    Track.new info["track_id"]
  end

  def self.search params
    puts params.map{|k,v| "&#{Rack::Utils.escape(k.to_s)}=#{v}"}.join
  end
end

