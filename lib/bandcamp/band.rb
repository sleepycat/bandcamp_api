require 'bandcamp/methodical'

module BandCamp
  class Band
    include Methodical

    def initialize attrs_hash
      to_methods attrs_hash
    end

  end
end
