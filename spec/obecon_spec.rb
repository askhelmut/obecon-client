# frozen_string_literal: true

require "spec_helper"

describe Obecon do
  it "raises ArgumentError when initialized with no options" do
    expect { described_class.new }.to raise_error(ArgumentError)
  end

  context "when initialized with an account name" do
    subject(:client) { described_class.new(domain_name: "unique_name") }

    describe "#options" do
      it { expect(client.options).to include(:domain_name) }
    end

    describe "#site" do
      it { expect(client.site).to eq("webs.sn.obecon.net") }
    end

    describe "#api_url" do
      it { expect(client.api_url).to eq("webs.sn.obecon.net/unique_name") }
    end

    describe "#movie" do
      before do
        stub_request(
          :get,
          "http://webs.sn.obecon.net/unique_name/CMFilm-Id/101933929",
        ).with(
          headers: {
            "User-Agent" => "ASK HELMUT Oberbaum Concept Client 0.0.5",
          },
        ).to_return(
          status: 200,
          body: '{"result":{"asset":[]}}',
          headers: {},
        )
      end

      it "constructs the query" do
        expect(Obecon::ResponseWrapper).to receive(:new)
        expect(Obecon::Client).to receive(:get).with("http://webs.sn.obecon.net/unique_name/CMFilm-Id/cm-film-id")

        client.movie("cm-film-id")
      end

      it "wraps the response object in a Obecon::ResponseWrapper" do
        expect(client.movie("101933929")).to be_an_instance_of Obecon::ResponseWrapper
      end
    end
  end
end
