require 'support/be_json'
require 'multi_json'
require 'bandcamp/band'
require 'bandcamp/album'

module Bandcamp
  describe Album do

    let(:album_hash){ MultiJson.decode File.read(File.join %w(spec fixtures remixes_and_rarities_album.json)) }
    let(:album){ Album.new(album_hash) }

    it "includes the Associated Module" do
      expect(album.private_methods).to include :retrieve_associated
    end

    it "includes the Methodical module" do
      expect(album.private_methods).to include :to_methods
    end

    describe ".new" do

      it "accepts a hash and returns an Album" do
        expect(album).to be_an Album
      end

      it "creates methods based on the hash" do
        expect(Album.new(foo: "bar").foo).to eq "bar"
      end
    end

    describe "#band" do
      it "returns the associated band" do
        album.stub(:retrieve_associated).and_return(Band.new(band_id: 123456789))
        expect(album.band).to be_a Band
      end
    end

    describe "#tracks" do
      it "returns an array of Track objects" do
        expect(album.tracks.first).to be_a Track
      end
    end

    describe "#to_json" do
      it "returns json" do
        expect(album.to_json).to be_json
      end
    end

  end
end
