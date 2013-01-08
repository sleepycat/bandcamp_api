require 'spec_helper'
require 'bandcamp'

describe BandCamp do

  describe ".config" do
    it 'returns a configuration object' do
      expect(BandCamp.config).to be_a (BandCamp::Configuration)
    end
  end

end
