module Bandcamp
  module Associated

    def retrieve_associated thing
      return instance_variable_get("@#{thing}") if instance_variable_defined?("@#{thing}")
      if [:band, :album, :track, :discography].include? thing
        response = get thing
        klass = Bandcamp.const_get "#{thing.capitalize}"
        instance_variable_set("@#{thing}", klass.new(response))
      end
    end

    def get thing
      request.send(thing.to_sym, self.send("#{thing}_id"))
    end

    def request
      Bandcamp::Request.new(Bandcamp.config.api_key)
    end

    private :retrieve_associated, :request, :get

  end
end
