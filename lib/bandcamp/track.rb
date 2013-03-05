require 'bandcamp/band'
require 'bandcamp/request'
require 'bandcamp/methodical'
require 'bandcamp/associated'

module Bandcamp
  class Track

    include Methodical
    include Associated

    def initialize attrs
      @attrs_hash = attrs
      to_methods @attrs_hash
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

    def to_json
      MultiJson.encode @attrs_hash
    end

  end
end
