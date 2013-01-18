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

    def album album_id
      response = @request.album album_id
      response.nil? ? nil : Album.new(response)
    end

  end
end
