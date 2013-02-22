require 'multi_json'

module Bandcamp
  module Jsonifier

    def to_json
      json_hash = {}
      self.class._included_in_json.each{|method| json_hash[method]= self.send(method) }
      MultiJson.encode(json_hash)
    end

    def self.included base
      base.extend ClassMethods
    end

    module ClassMethods

      attr_writer :_included_in_json

      def jsonifiable_methods options = {}
        if options[:blacklist]
          @_included_in_json = instance_methods(false).reject{|method| options[:blacklist] == method}
        end
        if options[:whitelist]
          @_included_in_json = [*options[:whitelist]]
        end

        if options.empty?
          @_included_in_json = instance_methods(false)
        end

      end

      def _included_in_json
        #to_json must never call to_json!
        @_included_in_json.reject{|method| method == :to_json}
      end
    end

  end
end
