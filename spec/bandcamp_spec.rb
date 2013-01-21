require 'spec_helper'
require 'bandcamp/band'
require 'bandcamp'

describe BandCamp do

  let(:getter) do
    Class.new do
      def search name
        [BandCamp::Band.new(foo: "bar"), BandCamp::Band.new(fizz: "buzz")]
      end
    end.new
  end

  before(:each) { BandCamp.config.api_key = "abc123" }

  describe ".config" do
    it 'returns a configuration object' do
      expect(BandCamp.config).to be_a (BandCamp::Configuration)
    end
  end

  describe ".get" do
    it "returns an object for making requests" do
      expect(BandCamp.get).to be_a BandCamp::Getter
    end
  end

  describe ".search" do
    it "accepts a band name to search for" do
      BandCamp.stub(:request).and_return(getter)
      expect(BandCamp.search "pitch black").to have(2).bands
    end
  end

  describe ".resolve" do
    it "returns an object for making requests" do
      expect(BandCamp.get).to be_a BandCamp::Getter
    end
  end

end
