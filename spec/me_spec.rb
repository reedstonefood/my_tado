# frozen_string_literal: true

RSpec.describe MyTado::Request::Me do
  subject { MyTado::Request::Me.new("abc", {}) }
  it "sends the expected request" do
    expect(MyTado::Request::AbstractRequest).to receive(:get).with(
      subject.endpoint,
      { body: nil, headers: { "Authorization" => "Bearer abc" } },
    )
    puts subject.call
  end
end
