require 'bandcamp/getter'
require 'bandcamp/request'
require 'bandcamp/track'
require 'bandcamp/album'

module BandCamp
  describe Getter do

    let(:request) do
      Class.new do

        def track id
          case
          when id.to_s.include?("1111")
            nil
          when id.to_s.include?(',')
            json = File.read(File.join %w(spec fixtures tracks.json))
            MultiJson.decode json
          else
            json = File.read(File.join %w(spec fixtures a_new_day.json))
            MultiJson.decode json
          end
        end

        def album id
          return nil if id == 1111
          json = File.read(File.join %w(spec fixtures remixes_and_rarities_album.json))
          MultiJson.decode json
        end

      end.new

    end

    let(:getter){ Getter.new request }

    describe ".new" do
      it "takes a request object" do
        expect(Getter.new(request)).to be_a Getter
      end
    end

    describe "#track" do
      context "when passed a single track id" do
        it "returns a Track" do
          expect(getter.track(1784614291)).to be_a Track
        end

        it "returns nil if nothing is found" do
          expect(getter.track 1111).to be_nil
        end
      end
    end

    describe "#album" do
      context "when the album exists" do
        it "returns an album" do
          expect(getter.album(405027664)).to be_an Album
        end
      end

      context "when the album does not exist" do
        it "returns nil" do
          expect(getter.album(1111)).to be_nil
        end
      end

    end

    describe "#tracks" do
      it "takes an array of track ids and returns an array of tracks" do
        expect(getter.tracks 1735088360, 1739611553).to have(2).tracks
      end

      context "when no tracks are found" do
        it "returns an empty array" do
          expect(getter.tracks(1111,1111)).to eq []
        end
      end
    end


  end
end
