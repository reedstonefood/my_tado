# frozen_string_literal: true

RSpec.describe MyTado::Client do
  subject { MyTado::Client.new(nil) }
  it "dynamically creates expected methods" do
    MyTado::Client::IMPLEMENTED_ENDPOINTS.each do |method|
      expect(subject.methods).to include(method)
    end
  end
end
