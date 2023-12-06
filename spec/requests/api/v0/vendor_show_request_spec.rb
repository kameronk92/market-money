require 'rails_helper'

RSpec.describe "Vendor Show Requests" do
  it "sends details of a single vendor, happy" do
    vendor = create(:vendor)

    get api_v0_vendor_path(vendor.id)

    expect(response).to be_successful
    expect(response.status).to eq(200)

    vendor = JSON.parse(response.body, symbolize_names: true)

    expect(vendor).to have_key(:data)
    expect(vendor[:data]).to be_a(Hash)

    expect(vendor[:data]).to have_key(:id)
    expect(vendor[:data][:id]).to be_a(String)

    expect(vendor[:data]).to have_key(:type)
    expect(vendor[:data][:type]).to eq("vendor")

    expect(vendor[:data]).to have_key(:attributes)
    expect(vendor[:data][:attributes]).to be_a(Hash) 

    attributes = vendor[:data][:attributes]

    expect(attributes).to have_key(:name)
    expect(attributes[:name]).to be_a(String)

    expect(attributes).to have_key(:description) 
    expect(attributes[:description]).to be_a(String)

    expect(attributes).to have_key(:contact_name)
    expect(attributes[:contact_name]).to be_a(String)

    expect(attributes).to have_key(:contact_phone)
    expect(attributes[:contact_phone]).to be_a(String)

    expect(attributes).to have_key(:credit_accepted)
    expect(attributes[:credit_accepted]).to be_in([true, false])
  end

  it "sends details of a single vendor, sad" do
    expect Vendor.count.zero?

    get api_v0_vendor_path(1)

    expect(response).to_not be_successful
    expect(response.status).to eq(404)

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data[:errors]).to be_a(Array)
    expect(data[:errors].first[:detail]).to eq("Couldn't find Vendor with 'id'=1")
  end
end