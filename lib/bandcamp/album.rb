require 'bandcamp/methodical'

module BandCamp
  class Album

    include Methodical

    def initialize album_hash
      to_methods album_hash
    end


  end
end
