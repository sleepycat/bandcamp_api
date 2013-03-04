require 'bandcamp/band'
require 'bandcamp/request'
require 'bandcamp/methodical'
require 'bandcamp/associated'

module Bandcamp
  class Track

    include Methodical
    include Associated

    def initialize attrs
      to_methods attrs
    end

    def paid?
      downloadable == 2 ? true : false
    end

    def free?
      downloadable == 1 ? true : false
    end

    def band
      retrieve_associated :band
    end

    def album
      retrieve_associated :album
    end

  end
end
