require 'spec_helper'
require 'bandcamp/methodical'

module BandCamp

  describe Methodical do

    let(:klass) do
      Class.new do

        include Methodical

        def initialize hash
          to_methods hash
        end

      end
    end
    let(:data){ {foo: "bar"} }

    describe "#to_methods" do

      it "creates instance methods from a hash" do
        expect(klass.new(data).public_methods).to include(:foo)
      end

      it "is a private method" do
        expect(klass.new(data).private_methods).to include(:to_methods)
      end

    end

  end

end
