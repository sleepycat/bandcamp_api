require 'support/be_json'
require 'bandcamp/band'

module Bandcamp
  describe Band do
    let(:band){Band.new(foo: "bar") }

    it "mixes in Methodical" do
      # passing in true here because to_methods is private
      expect(band.respond_to?(:to_methods, true)).to be true
    end

    describe ".new" do
      it "accepts a hash and returns a Band" do
        expect(band).to be_a Band
      end
      it "creates methods based on the hash" do
        expect(band.foo).to eq "bar"
      end
    end

    describe "#to_json" do
      it "returns json" do
        expect(band.to_json).to be_json
      end
    end
  end
end
