require 'bandcamp/track'
require 'bandcamp/request'

module BandCamp
  class Getter

    def initialize request
      @request = request
    end

    def track track_id
      response = @request.track(track_id)
      Track.new response unless response.nil?
    end

  end
end
