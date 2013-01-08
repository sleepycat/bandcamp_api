require File.expand_path('spec_helper', File.dirname(__FILE__))
require 'bandcamp/request'

module BandCamp
  describe Request do

    let(:request){ Request.new  }
    let(:json){ File.read(File.join(%w(spec fixtures a_new_day.json))) }


    describe '#initialize' do
      it 'sets the base uri' do
        expect(request.host).to eq "api.bandcamp.com"
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
      it 'sets the path according to type' do
        # types include: band, album, track, discography, url
        request.type :discography
        expect(request.path).to eq "/api/band/3/discography"
        request.type :url
        expect(request.path).to eq '/api/url/1/info'
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

    it 'fetches data' do
      request.should_receive(:get).and_return(json)
      BandCamp.config.api_key = "1234"
      request.type :track
      request.query= {track_id: 1784614291}
      expect(request.dispatch).to eq MultiJson.decode(json)
    end

  end
end
