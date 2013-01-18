require 'bandcamp/album'

module BandCamp
  describe Album do
    describe ".new" do

      it "accepts a hash and returns an Album" do
        expect(Album.new(foo: "bar")).to be_an Album
      end

      it "creates methods based on the hash" do
        expect(Album.new(foo: "bar").foo).to eq "bar"
      end
    end
  end
end
