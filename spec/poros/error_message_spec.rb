require "rails_helper"

RSpec.describe "error_message PORO" do
  it "initializes with a status code and message" do
    error_message = ErrorMessage.new("This is a test, this is only a test", 400)

    expect(error_message.message).to eq("This is a test, this is only a test")
    expect(error_message.status_code).to eq(400)
  end

  describe "#detail" do 
    it "returns a string message dependent on the status code" do
      error_1 = ErrorMessage.new(["This is a test, this is only a test"], 400)

      expect(error_1.detail).to eq("Validation failed: This is a test, this is only a test")

      error_2 = ErrorMessage.new("This is a test, this is only a test", 404)

      expect(error_2.detail).to eq("This is a test, this is only a test")

      error_3 = ErrorMessage.new("This is a test, this is only a test", 500)

      expect(error_3.detail).to eq("He's dead, Jim. Error Code 500")
    end
  end
end
