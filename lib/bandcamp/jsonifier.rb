require 'multi_json'

#
# Usage:
#
# class Foo
#   include Jsonify
#   jsonify_only :bar
#
#   def bar; "bar" end
#   def baz; "baz" end
# end
#
# Foo.new.to_json will look like:
# "{\"bar\":\"bar\"}"
#
# You can blacklist methods with:
#
# class Foo
#   include Jsonify
#   jsonify_all_except :bar
#
#   def bar; "bar" end
#   def baz; "baz" end
# end
#
# Foo.new.to_json will look like:
# "{\"baz\":\"baz\"}"


module Bandcamp
  module Jsonifier

    def self.included base
      base.extend ClassMethods
    end

    def to_json
      options = self.class.instance_variable_get :@_included_in_json
      all_methods = case
                    when options[:blacklist]
                      singleton_methods.concat(self.class.instance_methods(false)).reject{|method| [*options[:blacklist]].include? method}
                    when options[:whitelist]
                      [*options[:whitelist]]
                    when options[:all]
                      singleton_methods.concat(self.class.instance_methods(false))
                    end

      json_hash = {}
      all_methods.reject{|method| method == :to_json}.each{|method| json_hash[method]= self.send(method) }
      MultiJson.encode(json_hash)
    end

    module ClassMethods

      def jsonifiable_methods options = {}
        @_included_in_json = options
      end

      def jsonify_only *methods
        jsonifiable_methods whitelist: methods
      end

      def jsonify_all_except *methods
        jsonifiable_methods blacklist: methods
      end

    end

  end
end
