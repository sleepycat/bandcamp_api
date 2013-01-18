require 'spec_helper'
require 'bandcamp'

describe BandCamp do

  before(:each) { BandCamp.config.api_key = "abc123" }

  describe ".config" do
    it 'returns a configuration object' do
      expect(BandCamp.config).to be_a (BandCamp::Configuration)
    end
  end

  describe ".get" do
    it "returns a get object for making requests" do
      expect(BandCamp.get).to be_a BandCamp::Getter
    end

  end

end
