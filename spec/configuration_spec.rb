require 'bandcamp/configuration'

module Bandcamp
  describe Configuration do

    describe "#api_key" do

      let(:config){ Configuration.new }

      it "returns the key" do
        config.api_key = "abc123"
        expect(config.api_key).to eq "abc123"
      end

      context "when there is no key" do
        it "raises an error" do
          expect{ config.api_key }.to raise_error ConfigurationError
        end
      end

    end
  end
end
