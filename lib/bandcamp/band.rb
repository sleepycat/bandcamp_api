require 'bandcamp/methodical'

module Bandcamp
  class Band
    include Methodical

    def initialize attrs_hash
      to_methods attrs_hash
    end

  end
end
