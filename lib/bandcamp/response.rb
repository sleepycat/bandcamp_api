require 'multi_json'

module Bandcamp
  class Response
    def initialize json_string
      @json = json_string
    end

    def to_json
      @json
    end

    def to_hash
      MultiJson.decode @json
    end

  end
end
