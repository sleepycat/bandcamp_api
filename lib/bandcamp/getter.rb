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

  end
end
