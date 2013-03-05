require 'multi_json'
require 'bandcamp/methodical'

module Bandcamp
  class Band
    include Methodical

    def initialize attrs_hash
      @attrs_hash = attrs_hash
      to_methods @attrs_hash
    end

    def to_json
      MultiJson.encode @attrs_hash
    end

  end
end
