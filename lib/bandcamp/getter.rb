require 'bandcamp/band'
require 'bandcamp/album'
require 'bandcamp/track'
require 'bandcamp/request'

module BandCamp
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
        response["results"].collect{|band_json| Band.new band_json}
      end
    end

  end
end
