require "rails_helper"

RSpec.describe "error serializer" do
  it "should include a correct title" do
    error =     {
      errors: [
        {
          status: "400",
          title: "he's dead, jim"
        }
      ]
    }
    serializer = ErrorSerializer.new(error)
    serialized_error = JSON.parse(serializer.to_json, symbolize_names: true)

    expect(serialized_error[:error_object][:errors][0][:title]).to eq(error[:errors][0][:title])
  end
end