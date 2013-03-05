require 'spec_helper'
require 'bandcamp/response'

module Bandcamp
  describe Response do
    let(:response){ Response.new("{\"foo\":\"bar\"}")}

    describe "#to_json" do
      it "returns json" do
        expect(response.to_json).to eq "{\"foo\":\"bar\"}"
      end
    end

    describe "#to_hash" do
      it "returns a hash" do
        expect(response.to_hash).to eq "foo" => "bar"
      end
    end
  end
end
