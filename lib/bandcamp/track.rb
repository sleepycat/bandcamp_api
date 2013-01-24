require 'bandcamp/methodical'

module Bandcamp
  class Track

    include Bandcamp::Methodical

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
