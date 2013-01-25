require 'bandcamp/request'
require 'bandcamp/band'
require 'bandcamp/associated'

module Bandcamp

  describe Associated do

    let(:klass) do
      Class.new do
        include Associated

        def band_id
          950934886
        end

        def band
          retrieve_associated :band
        end

      end.new
    end

    let(:faux_request) do
      Class.new do
        def band *args
          {band_id: 950934886}
        end
      end.new
    end

    it "adds the retrieve_associated method" do
      expect(klass.private_methods).to include :retrieve_associated
    end

    context "requests associated data from api using _id attributes" do
      context "when band is passed" do
        it "returns a band object" do
          klass.stub(:get).and_return({band_id: 950934886})
          expect(klass.band).to be_a Band
        end

        it "calls band_id to find the id to request" do
          klass.stub(:request).and_return(faux_request)
          klass.should_receive(:band_id).and_return 950934886
          klass.band
        end
      end
    end
  end

end

