require 'bandcamp/getter'
require 'bandcamp/request'
require 'bandcamp/track'

module BandCamp
  describe Getter do

    let(:request) do
      Class.new do

        def track id
          if id == 1111
            nil
          else
            json = File.read(File.join %w(spec fixtures a_new_day.json))
            MultiJson.decode json
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
      context "when passed a single track id" do
        it "returns a Track" do
          expect(getter.track(1784614291)).to be_a Track
        end
        it "returns nil if nothing is found" do
          expect(getter.track 1111).to be_nil
        end
      end
    end
  end
end
