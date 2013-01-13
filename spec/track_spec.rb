require 'spec_helper'
require 'bandcamp/track'
require 'multi_json'

module BandCamp

  describe Track do

    it "includes BandCamp::Methodical" do
      expect(Track.ancestors).to include(BandCamp::Methodical)
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

  end

end
