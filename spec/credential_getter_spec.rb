# frozen_string_literal: true

RSpec.describe MyTado::CredentialGetter do
  subject { MyTado::CredentialGetter.new(test_file) }
  let(:test_file) { "lib/secrets.example.yml" }

  it "reads the correct values from the example file" do
    expect(subject.client_secret).to eq("wZaRN7rpjn3FoNyF5IFuxg9uMzYJcvOoQ8QWiIqS3hfk6gLhVlG57j5YNoZL2Rtc")
    expect(subject.home_id).to eq(123)
    expect(subject.password).to eq("bad_passw0rd")
    expect(subject.refresh_token).to eq("xyz")
    expect(subject.username).to eq("joe@example.com")
  end

  context "when using valid hash input" do
    let(:test_hash) { { client_secret: "no", home_id: "456", refresh_token: "pls" } }
    subject { MyTado::CredentialGetter.new(test_hash) }

    it "it reads the correct values" do
      expect(subject.client_secret).to eq("no")
      expect(subject.home_id).to eq(456)
      expect(subject.refresh_token).to eq("pls")
    end
  end

  context "when using invalid hash input" do
    let(:test_bad_hash) { { client_secret: "no", home_id: "pi", refresh_token: "pls" } }

    it "returns the appropriate error" do
      expect { MyTado::CredentialGetter.new(test_bad_hash) }
        .to raise_error(MyTado::CredentialGetter::HomeIDNotAnIntegerError)
    end
  end
end
