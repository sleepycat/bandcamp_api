require 'spec_helper'
require 'bandcamp/band'
require 'bandcamp'

describe Bandcamp do

  let(:getter) do
    Class.new do
      def search name
        [Bandcamp::Band.new(foo: "bar"), Bandcamp::Band.new(fizz: "buzz")]
      end
    end.new
  end

  before(:each) { Bandcamp.config.api_key = "abc123" }

  describe ".config" do
    it 'returns a configuration object' do
      expect(Bandcamp.config).to be_a (Bandcamp::Configuration)
    end
  end

  describe ".get" do
    it "returns an object for making requests" do
      expect(Bandcamp.get).to be_a Bandcamp::Getter
    end
  end

  describe ".search" do
    it "accepts a band name to search for" do
      Bandcamp.stub(:request).and_return(getter)
      expect(Bandcamp.search "pitch black").to have(2).bands
    end
  end

  describe ".resolve" do
    it "returns an object for making requests" do
      expect(Bandcamp.get).to be_a Bandcamp::Getter
    end
  end

end
