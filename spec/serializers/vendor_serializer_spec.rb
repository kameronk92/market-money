require "rails_helper"

RSpec.describe "vendor serializer" do
  it "should include a correct name" do
    vendor = create(:vendor)
    serializer = VendorSerializer.new(vendor)
    expect(serializer.serializable_hash[:data][:attributes][:name]).to eq(vendor.name)
  end
end