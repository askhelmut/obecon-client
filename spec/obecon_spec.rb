# frozen_string_literal: true

require "spec_helper"

describe Obecon do
  it "raises ArgumentError when initialized with no options" do
    expect { described_class.new }.to raise_error(ArgumentError)
  end

  context "when initialized with an account name" do
    subject(:client) { described_class.new(token: "test_token") }

    describe "#options" do
      it { expect(client.options).to include(:token) }
    end

    describe "#site" do
      it { expect(client.host).to eq("www.rce-event.de") }
    end

    describe "#movie" do
      subject {
        VCR.use_cassette("movie_request") do
          client.movie("141552831")
        end
      }

      it "wraps the response object in a Obecon::ResponseWrapper" do
        is_expected.to be_an_instance_of Obecon::ResponseWrapper
      end
    end
  end
end
