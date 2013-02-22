require 'spec_helper'
require 'bandcamp/jsonifier'

module Bandcamp
  describe Jsonifier do

    let(:klass) do
      Class.new do
        include Jsonifier

        def foo; "bar" end
        def fizz; "buzz" end
        def zig; "zag" end

      end.new
    end

    it "provides a #to_json method" do
      expect(klass.public_methods).to include :to_json
    end

    it "creates .jsonifiable_methods" do
      expect(klass.class.methods).to include :jsonifiable_methods
    end

    describe "#to_json" do
      it "creates json for whitelisted methods" do
        klass.class.class_eval  "jsonifiable_methods(whitelist: :foo)"
        expect(klass.to_json).to eq "{\"foo\":\"bar\"}"
      end

      it "blacklisted methods are not included in json" do
        klass.class.class_eval  "jsonifiable_methods(blacklist: :foo)"
        expect(klass.to_json).to eq "{\"fizz\":\"buzz\",\"zig\":\"zag\"}"
      end

      it "will not call to_json" do
        klass.class.class_eval  "jsonifiable_methods(whitelist: [:foo, :to_json])"
        expect(klass.to_json).to eq "{\"foo\":\"bar\"}"
      end

    end

  end
end
