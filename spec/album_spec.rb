require 'bandcamp/album'

module Bandcamp
  describe Album do

    let(:album){ Album.new(foo: "bar", band_id: 123456) }

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
  end
end
