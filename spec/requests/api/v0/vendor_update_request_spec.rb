require "rails_helper"

RSpec.describe "Vendor Update Requests" do
  it "can update a vendor, happy" do
    vendor = create(:vendor)

    not_updated_name = vendor.name
    not_updated_description = vendor.description

    updated_params = { name: "Kylo Ren", description: "Dad assassin" }

    patch api_v0_vendor_path(vendor.id), params: updated_params

    expect(not_updated_name).to_not eq(updated_params[:name])
    expect(not_updated_description).to_not eq(updated_params[:description])
    expect(response).to be_successful
    expect(response.status).to eq(202)

    vendor = JSON.parse(response.body, symbolize_names: true)

    expect(vendor).to have_key(:data)
    expect(vendor[:data]).to be_a(Hash)
    expect(vendor[:data]).to have_key(:attributes)
    expect(vendor[:data][:attributes]).to be_a(Hash) 

    attributes = vendor[:data][:attributes]

    expect(attributes).to have_key(:name)
    expect(attributes[:name]).to eq("Kylo Ren")
    expect(attributes).to have_key(:description)
    expect(attributes[:description]).to eq("Dad assassin")
  end

  describe "can update a vendor, sad" do
    it "has a response status of 404 if vendor does not exist" do
      expect(Vendor.count).to be_zero

      updated_params = { id: 2, name: "Kylo Ren", description: "Dad assassin" }

      patch api_v0_vendor_path(1), params: updated_params

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors]).to be_a(Array)
      expect(data[:errors].first[:detail]).to eq("Couldn't find Vendor with 'id'=1")
    end

    it "has a response status of 400 if vendor cannot be updated" do
      vendor = create(:vendor, id: 1)

      updated_params = { name: nil, description: nil }

      patch api_v0_vendor_path(1), params: updated_params

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      data = JSON.parse(response.body, symbolize_names: true)
      
      expect(data[:errors]).to be_a(Array)
      expect(data[:errors].first[:detail]).to eq("Validation failed: Name can't be blank, Description can't be blank")
    end
  end
end