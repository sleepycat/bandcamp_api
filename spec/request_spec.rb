require File.expand_path('spec_helper', File.dirname(__FILE__))
require 'bandcamp/request'

module BandCamp
  describe Request do

    let(:request){ Request.new "1234" }
    let(:track_json){ File.read(File.join(%w(spec fixtures a_new_day.json))) }
    let(:album_json){ File.read(File.join(%w(spec fixtures remixes_and_rarities_album.json))) }
    let(:band_json){ File.read(File.join(%w(spec fixtures pitch_black_band.json))) }
    let(:discography_json){ File.read(File.join(%w(spec fixtures pitch_black_discography.json))) }
    let(:unknown_band_json){ File.read(File.join(%w(spec fixtures unknown_band.json))) }
    let(:unknown_band_discography_json){ File.read(File.join(%w(spec fixtures unknown_band_discography.json))) }
    let(:url_json){ File.read(File.join(%w(spec fixtures url.json))) }
    let(:url_error_json){ File.read(File.join(%w(spec fixtures unknown_url.json))) }

    let(:search_json){ File.read(File.join(%w(spec fixtures search.json))) }
    let(:no_results_json){ File.read(File.join(%w(spec fixtures search_no_results.json))) }

    describe '#initialize' do
      it 'sets the base uri' do
        expect(request.host).to eq "api.bandcamp.com"
      end

      it "is instantiated with an API key" do
        r = Request.new "abc123"
        expect(r.api_key).to eq "abc123"
      end
    end

    describe '#uri' do
      it 'returns the completed uri' do
        expect(request.uri).to eq 'http://api.bandcamp.com'
      end
    end

    describe '#path' do
      it 'allows setting an arbitrary path' do
        request.path = '/foo'
        expect(request.path).to eq "/foo"
      end

      it 'rejects craziness' do
        expect {request.path = '@!#%^$+*(&' }.to raise_error(URI::InvalidComponentError)
      end

    end

    describe '#type' do
      # types include: band, album, track, discography, url
      context "when type is discography" do
        it "sets the path accordingly" do
          request.type :discography
          expect(request.path).to eq "/api/band/3/discography"
        end
      end

      context "when type is url" do
        it "sets the path accordingly" do
          request.type :url
          expect(request.path).to eq '/api/url/1/info'
        end
      end

      it 'raises an error for unrecognized types' do
        expect{ request.type(:foo) }.to raise_error(UnknownTypeError)
      end

    end

    describe '#query' do
      it 'creates a query string from a hash' do
        BandCamp.config.api_key = '1234'
        request.query = {name: "pitch black", album: "ape to angel"}
        expect(request.query).to eq "key=1234&name=pitch%20black&album=ape%20to%20angel"
      end
    end

    it 'builds a uri' do
      BandCamp.config.api_key = 1234
      request.type :track
      request.query= {track_id: 1784614291}
      expect(request.uri).to eq "http://api.bandcamp.com/api/track/3/info?key=1234&track_id=1784614291"
    end

    describe "#track" do
      it "requests the correct uri" do
        uri = URI("http://api.bandcamp.com/api/track/3/info?key=1234&track_id=1784614291")
        request.should_receive(:get).with(uri).and_return(track_json)
        request.track(1784614291)
      end

      it "returns a hash of track attributes" do
        request.stub(:get).and_return(track_json)
        expect(request.track(1784614291)).to be_a Hash
      end

      context "when track does not exist" do
        it "returns nil" do
          request.stub(:get).and_return("{}")
          expect(request.track(11111)).to be_nil
        end
      end

    end

    describe "#album" do
      it "requests the correct url" do
        uri = URI("http://api.bandcamp.com/api/album/2/info?key=1234&album_id=405027664")
        request.should_receive(:get).with(uri).and_return(album_json)
        request.album(405027664)
      end

      it "returns a hash of album attributes" do
        request.stub(:get).and_return(album_json)
        expect(request.album(405027664)).to be_a Hash
      end

      context "when album does not exist" do
        it "returns nil" do
          request.stub(:get).and_return("{}")
          expect(request.album(11111)).to be_nil
        end
      end
    end

    describe "#band" do
      it "requests the proper uri" do
        uri = URI("http://api.bandcamp.com/api/band/3/info?key=1234&band_id=950934886")
        request.should_receive(:get).with(uri).and_return(band_json)
        request.band(950934886)
      end

      it "returns a hash of band attributes" do
        request.stub(:get).and_return(band_json)
        expect(request.band(950934886)).to be_a Hash
      end

      it 'returns nil when no band is found' do
        request.stub(:get).and_return(unknown_band_json)
        expect(request.band(1234)).to eq nil
      end
    end

    describe "#url" do
      it "returns a hash of ids" do
        request.stub(:get).and_return(url_json)
        expect(request.url("pitchblack.bandcamp.com")).to be_a Hash
      end
      it "requests the proper uri" do
        uri = URI("http://api.bandcamp.com/api/url/1/info?key=1234&url=pitchblack.bandcamp.com")
        request.should_receive(:get).with(uri).and_return(url_json)
        request.url "pitchblack.bandcamp.com"
      end
      it "returns nil for unknown uris" do
        uri = URI("http://api.bandcamp.com/api/url/1/info?key=1234&url=foo")
        request.should_receive(:get).with(uri).and_return(url_error_json)
        expect(request.url "foo").to be_nil
      end
    end

    describe "#search" do
      it "requests the proper uri" do
        uri = URI("http://api.bandcamp.com/api/band/3/search?key=1234&name=pitch%20black")
        request.should_receive(:get).with(uri).and_return(search_json)
        request.search("pitch black")
      end

      it "returns an array of hashes" do
        request.stub(:get).and_return(search_json)
        expect(request.search("pitch black")).to be_an Array
      end

      it 'returns nil when no results are found' do
        request.stub(:get).and_return(no_results_json)
        expect(request.search("foo")).to eq nil
      end
    end

    describe "#discography" do
      it "requests the proper uri" do
        uri = URI("http://api.bandcamp.com/api/band/3/discography?key=1234&band_id=950934886")
        request.should_receive(:get).with(uri).and_return(discography_json)
        request.discography(950934886)
      end

      it "returns an array of hashes" do
        request.stub(:get).and_return(discography_json)
        expect(request.discography(950934886)).to be_an Array
      end

      it 'returns nil when no discography is found' do
        request.stub(:get).and_return(unknown_band_discography_json)
        expect(request.discography(1234)).to eq nil
      end
    end

    describe "#dispatch" do
      it "calls get with a URI object" do
        request.should_receive(:get).with(kind_of(URI)).and_return(band_json)
        request.band 950934886
      end
    end

  end
end
