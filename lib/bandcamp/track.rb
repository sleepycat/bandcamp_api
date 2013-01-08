module BandCamp
  class Track
    attr_reader :duration, :track_id, :url, :title,
      :band_id, :large_art_url, :small_art_url,
      :about, :number, :album_id, :downloadable,
      :credits, :lyrics, :streaming_url

    def initialize id
      track = MultiJson.decode(open("http://api.bandcamp.com/api/track/3/info?key=#{config.api_key}&track_id=#{id}&debug").read)
      track.each_pair do |key,val|
        instance_variable_set("@#{key}", val)
      end
    end

    def paid?
      downloadable == 2 ? true : false
    end

    def free?
      downloadable == 1 ? true : false
    end

  end
end
