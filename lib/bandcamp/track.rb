require 'bandcamp/methodical'

module BandCamp
  class Track

    include BandCamp::Methodical

    def initialize attrs
      to_methods attrs
    end

    def paid?
      downloadable == 2 ? true : false
    end

    def free?
      downloadable == 1 ? true : false
    end

  end
end
