# frozen_string_literal: true

require "spec_helper"

describe Obecon::ResponseWrapper do
  let(:client) { Obecon.new(token: "test_token") }
  let(:wrapped_response) {
    VCR.use_cassette("movie_request") do
      client.movie("141552831")
    end
  }

  describe "#gallery" do
    subject(:gallery) { wrapped_response.gallery }

    it "returns an array" do
      is_expected.to be_an_instance_of(Array)
    end
    it "contains Asset Objects" do
      expect(gallery.first).to be_an_instance_of(Obecon::Asset)
    end
  end

  describe "#poster" do
    it "returns an Asset" do
      expect(wrapped_response.poster.first).to be_an_instance_of(Obecon::Asset)
    end
  end

  describe "#map_by_slots" do
    let(:asset_1) { { "slot" => "filmplakat" } }
    let(:asset_2) { { "slot" => "teaser" } }

    it "maps assets by slot" do
      expect(wrapped_response.send(:map_by_slots, [asset_1, asset_2])).to eq(filmplakat: [asset_1], teaser: [asset_2])
    end
  end
end
