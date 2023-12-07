require "rails_helper"

RSpec.describe "Vendor Delete Requests" do
  it "deletes a vendor from the vendors list, happy" do
    expect(Vendor.count).to be_zero

    vendor = create(:vendor)

    expect(Vendor.count).to eq(1)

    delete api_v0_vendor_path(vendor.id)

    expect(response).to be_successful

    expect(response.body).to be_empty
    expect(response.status).to eq(204)

    expect(Vendor.count).to be_zero
  end

  it "delete a vendor from the vendors list, sad" do
    expect(Vendor.count).to be_zero

    vendor = create(:vendor, id: 1)

    delete api_v0_vendor_path(2)

    expect(response).to_not be_successful
    expect(response.status).to eq(404)

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data[:errors]).to be_a(Array)
    expect(data[:errors].first[:detail]).to eq("Couldn't find Vendor with 'id'=2")
  end
end