# frozen_string_literal: true

RSpec.describe MyTado do
  it "has a version number" do
    expect(MyTado::VERSION).not_to be nil
  end

  it "when new is called, returns a Client" do
    expect(MyTado.new("test")).to be_a_kind_of(MyTado::Client)
  end
end
