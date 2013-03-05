require 'spec_helper'
require 'support/be_json'
require 'bandcamp/track'
require 'multi_json'

module Bandcamp

  describe Track do

    it "includes Bandcamp::Methodical" do
      expect(track.private_methods).to include(:to_methods)
    end

    it "includes Bandcamp::Associated" do
      expect(track.private_methods).to include(:retrieve_associated)
    end

    let(:track_json){ MultiJson.decode(File.read(File.join %w(spec fixtures a_new_day.json))) }
    let(:track){Track.new(track_json)}

    describe "#new" do

      it "is called with a hash" do
        Track.should_receive(:new).with(instance_of Hash)
        track
      end

      it "creates reader methods from keys and values" do
        expect(track.track_id).to eq 1784614291
      end

    end

    describe "#paid?" do
      it "tells you if the track is paid or not" do
        expect(track.paid?).to eq true
      end
    end

    describe "#free?" do
      it "tells you if the track is free or not" do
        expect(track.free?).to eq false
      end
    end

    describe "#band" do
      it "returns the associated band object" do
        track.stub(:retrieve_associated).and_return(Band.new(foo: "bar"))
        expect(track.band).to be_a Band
      end
    end

    describe "#album" do
      it "returns the associated album object" do
        track.stub(:retrieve_associated).and_return(Album.new(foo: "bar"))
        expect(track.album).to be_an Album
      end
    end

    describe "#to_json" do
      it "returns json" do
        expect(track.to_json).to be_json
      end
    end

  end

end
