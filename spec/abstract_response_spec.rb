# frozen_string_literal: true

RSpec.describe MyTado::Response::AbstractResponse do
  let(:simple_input) do
    {
      "a_number" => 1,
      "some_text" => "foo",
      "length_24_text" => "012345678901234567890123",
      "date_as_text" => "2021-11-30T01:20:00.000Z",
    }
  end

  context "with simple input" do
    subject { MyTado::Response::AbstractResponse.new(simple_input) }
    it "converts text to date where appropriate" do
      expect(subject["date_as_text"]).to be_a(Date)
    end

    it "leaves other data types untouched" do
      expect(subject["a_number"]).to be_a(Integer)
      expect(subject["some_text"]).to be_a(String)
      expect(subject["length_24_text"]).to be_a(String)
    end
  end

  let(:nested_input) do
    {
      "a_number" => 1,
      "some_text" => "foo",
      "complex_data" => {
        "foo" => "bar",
        "foo_date" => "2021-12-25T03:33:00.000Z",
      },
      "date_as_text" => "2021-11-30T01:20:00.000Z",
    }
  end

  context "with nested input" do
    subject { MyTado::Response::AbstractResponse.new(nested_input) }
    it "converts all dates" do
      expect(subject["date_as_text"]).to be_a(Date)
      expect(subject["complex_data"]["foo"]).to be_a(String)
      expect(subject["complex_data"]["foo_date"]).to be_a(Date)
    end
  end
end
