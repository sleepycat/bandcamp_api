require 'bandcamp/track'
require 'bandcamp/associated'
require 'bandcamp/methodical'

module Bandcamp
  class Album

    include Methodical
    include Associated

    def initialize album_hash
      @album_hash = album_hash
      to_methods @album_hash
      if instance_variable_defined? "@tracks"
        @tracks = @tracks.map{|track| Track.new(track)}
      end
    end

    def band
      retrieve_associated :band
    end

    def to_json
      MultiJson.encode @album_hash
    end

  end
end
