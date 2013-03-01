require 'spec_helper'
require 'bandcamp/jsonifier'

module Bandcamp
  describe Jsonifier do

    let(:klass) do
      obj = Class.new do
        include Jsonifier

        def initialize
          class << self
            define_method(:foo){'bar'}
          end
        end
        def fizz; "buzz" end
        def zig; "zag" end
      end.new

      obj
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

    describe ".jsonify_only" do
      it "whitelists the given methods" do
        klass.class.class_eval  "jsonify_only :fizz, :zig"
        expect(klass.to_json).to eq "{\"fizz\":\"buzz\",\"zig\":\"zag\"}"
      end
    end

    describe ".jsonify_all_except" do
      it "blacklists the given methods" do
        klass.class.class_eval  "jsonify_all_except :foo, :zig"
        expect(klass.to_json).to eq "{\"fizz\":\"buzz\"}"
      end
    end

  end
end
