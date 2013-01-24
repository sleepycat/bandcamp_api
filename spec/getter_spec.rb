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

        def band name
          return nil if name == 111111
          json = File.read(File.join %w(spec fixtures pitch_black_band.json))
          MultiJson.decode json
        end

        def album id
          return nil if id == 1111
          json = File.read(File.join %w(spec fixtures remixes_and_rarities_album.json))
          MultiJson.decode json
        end

        def search name
          return nil if name == "Foo and the Bars"
          json = File.read(File.join %w(spec fixtures search.json))
          MultiJson.decode(json)["results"]
        end

        def url bandcamp_url
          case bandcamp_url
          when "http://pitchblack.bandcamp.com/"
            {"band_id"=>950934886}
          when "http://pitchblack.bandcamp.com/track/a-new-day-pitch-black-remix"
            {"band_id" => 950934886,"track_id" => 1784614291}
          when "http://interchill.bandcamp.com/album/power-salad"
            {"band_id"=>1589471525, "album_id"=>165628809}
          else
            nil
          end

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
      context "when passed a track id" do
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
      context "when given an array of track ids" do
        it "returns an array of tracks" do
          expect(getter.tracks 1735088360, 1739611553).to have(2).tracks
        end
      end

      context "when no tracks are found" do
        it "returns an empty array" do
          expect(getter.tracks(1111,1111)).to eq []
        end
      end
    end

    describe "#search" do
      context "when given a band name" do
        it "returns an array of Band objects" do
          expect(getter.search "pitch black").to have(5).bands
        end
      end
      context "when no results are found" do
        it "returns an empty array" do
          expect(getter.search "Foo and the Bars").to eq []
        end
      end
    end

    describe "#band" do
      context "when given a band name" do
        it "returns a Band object" do
          expect(getter.band(950934886).name).to eq "Pitch Black"
        end
      end

      context "when no band is found" do
        it "returns nil" do
          expect(getter.band(111111)).to be_nil
        end
      end
    end

    describe "#url" do
      context "when given a track url" do
        it "returns a Track" do
          expect(getter.url "http://pitchblack.bandcamp.com/track/a-new-day-pitch-black-remix" ).to be_a Track
        end
      end

      context "when given a band url" do
        it "returns a band" do
          expect(getter.url  "http://pitchblack.bandcamp.com/").to be_a Band
        end
      end

      context "when given an album url" do
        it "returns an album" do
          expect(getter.url "http://interchill.bandcamp.com/album/power-salad").to be_an Album
        end
      end

    end

  end
end
