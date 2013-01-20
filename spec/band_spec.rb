require 'bandcamp/band'

module BandCamp
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

  end
end
