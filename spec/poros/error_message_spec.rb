require "rails_helper"

RSpec.describe "error_message PORO" do
  it "initializes with a status code and message" do
    error_message = ErrorMessage.new("This is a test, this is only a test", 400)

    expect(error_message.message).to eq("This is a test, this is only a test")
    expect(error_message.status_code).to eq(400)
  end
end
