require "spec_helper"

describe Obecon do

  it "raises ArgumentError when initialized with no options" do
    expect{ Obecon.new }.to raise_error(ArgumentError)
  end

  context "initialized with an account name" do
    subject{Obecon.new(domain_name: "unique_name")}

    describe "#options" do
      it { expect(subject.options).to include(:domain_name) }
    end

    describe "#site" do
      it { expect(subject.site).to eq("webs.sn.obecon.net") }
    end

    describe "#api_url" do
      it { expect(subject.api_url).to eq("webs.sn.obecon.net/unique_name") }
    end

    describe "#movie" do
      it "constructs the query" do
        Obecon::ResponseWrapper.stub(:new)
        expect(Obecon::Client).to receive(:get).with("http://webs.sn.obecon.net/unique_name/CMFilm-Id/cm-film-id")
        subject.movie("cm-film-id")
      end

      it "wraps the response object in a Response" do
        stub_request(:get, "http://webs.sn.obecon.net/unique_name/CMFilm-Id/101933929").
          with(:headers => {'User-Agent'=>'ASK HELMUT Oberbaum Concept Client 0.0.4'}).
          to_return(:status => 200, :body => '{"result":{"asset":[]}}', :headers => {})
        expect(subject.movie("101933929")).to be_an_instance_of Obecon::ResponseWrapper
      end
    end
  end

end
