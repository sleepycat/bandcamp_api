require 'bandcamp'
require 'net/http'
require 'multi_json'

module Bandcamp

  # A helper class for assembling a uri to query the API

  class Request

    attr_reader :api_key

    def initialize api_key
      @uri = URI('http://api.bandcamp.com')
      @api_key = api_key
    end

    def host
      @uri.host
    end

    def path
      @uri.path
    end

    def path= path
      @uri.path = path
    end

    def track trackid
      self.type :track
      self.query = { track_id: trackid }
      response = dispatch
      response.empty? ? nil : response
    end

    def album albumid
      type :album
      self.query={ album_id: albumid }
      response = dispatch
      response.empty? ? nil : response
    end

    def band bandid
      type :band
      self.query={ band_id: bandid }
      response = dispatch
      response["error"] ? nil : response
    end

    def url bandcamp_url
      type :url
      self.query = {url: bandcamp_url}
      response = dispatch
      response["error"] ? nil : response
    end

    def discography bandid
      type :discography
      self.query = {band_id: bandid}
      response = dispatch
      response["discography"].empty? ? nil : response["discography"]
    end

    def search name
      type :search
      self.query = {name: name}
      response = dispatch
      response["results"].empty? ? nil : response["results"]
    end

    def type req_type
      self.path = case req_type
                  when :track
                    '/api/track/3/info'
                  when :album
                    '/api/album/2/info'
                  when :discography
                    '/api/band/3/discography'
                  when :search
                    '/api/band/3/search'
                  when :band
                    '/api/band/3/info'
                  when :url
                    '/api/url/1/info'
                  else
                    raise UnknownTypeError, "The Bandcamp API does not support this type of request."
                  end
    end

    def uri
      @uri.to_s
    end

    def query= params
      @uri.query = generate_params(params)
    end

    def query
      @uri.query
    end

    def generate_params params
      add_key_param(params).map{|key,val| "#{URI.encode(key.to_s)}=#{URI.encode(val.to_s)}"}.join('&')
    end

    def add_key_param params
      {key: @api_key}.merge params
    end

    def dispatch
      MultiJson.decode(get(@uri))
    end

    private

    def get uri
      Net::HTTP.get(uri)
    end

  end

  class UnknownTypeError < StandardError; end

end
