require 'bandcamp/band'
require 'bandcamp/album'
require 'bandcamp/track'
require 'bandcamp/request'

module Bandcamp
  class Getter

    def initialize request
      @request = request
    end

    def track track_id
      response = @request.track track_id
      response.nil? ? nil : Track.new(response)
    end

    def tracks *tracks
      track_list = tracks.join(',')
      response = @request.track track_list
      if response.nil?
        []
      else
        response.collect{|key,val| Track.new val}
      end
    end

    def album album_id
      response = @request.album album_id
      response.nil? ? nil : Album.new(response)
    end

    def search band_name
      response = @request.search band_name
      if response.nil?
        []
      else
        response.collect{|band_json| Band.new band_json}
      end
    end

    def band name
      response = @request.band name
      response.nil? ? nil : Band.new(response)
    end

    def url address
      response = @request.url address
      return nil if response.nil?
      case
      when response.has_key?("album_id")
        album(response["album_id"])
      when response.has_key?("track_id")
        track(response["track_id"])
      when (response.keys.length == 1) && response.has_key?("band_id")
        band(response["band_id"])
      end
    end

  end
end
