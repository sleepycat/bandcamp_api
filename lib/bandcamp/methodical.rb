module BandCamp
  module Methodical

    def to_methods hash
      eigenclass = class << self; self; end
      hash.each_pair do |key, val|
         eigenclass.instance_eval { attr_reader key.to_sym }
         instance_variable_set("@#{key}".to_sym, val)
      end
    end

    private :to_methods

  end
end
