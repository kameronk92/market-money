require "rails_helper"

RSpec.describe "Vendor Post Requests" do
  it "adds a vendor to the vendors list, happy" do
    Vendor.destroy_all
    expect(Vendor.count).to eq(0)

    new_vendor_params = {
      id: 1,
      name: "Blaine's Vapes",
      description: "lame vape shop",
      contact_name: "Blaine",
      contact_phone: "123-456-7890",
      credit_accepted: true
    }

    post api_v0_vendors_path, params: new_vendor_params

    expect(response).to be_successful
    expect(response.status).to eq(201)

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

  it "adds a vendor to the vendors list, sad" do
    Vendor.destroy_all
    expect(Vendor.count).to eq(0)

    new_vendor_params = {
      id: 1,
      description: "lame vape shop",
      contact_phone: "123-456-7890",
      credit_accepted: true
    }

    post api_v0_vendors_path, params: new_vendor_params

    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data[:errors]).to be_a(Array)
    expect(data[:errors].first[:detail]).to eq("Validation failed: Name can't be blank, Contact name can't be blank")
  end
end