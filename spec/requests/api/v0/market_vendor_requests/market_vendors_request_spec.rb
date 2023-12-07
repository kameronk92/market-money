require "rails_helper"

RSpec.describe "market vendors requests" do
  describe "returns all vendors belonging to a market" do
    it "happy path" do
      create(:market, id: 1)

      vendors = create_list(:vendor, 5)

      vendors.each do |vendor|
        market = Market.find_by(id: 1)
        vendor.markets << market
      end
      
      get '/api/v0/markets/1/vendors'
      
      expect(response).to be_successful
      expect(response.status).to eq(200)

      vendors = JSON.parse(response.body, symbolize_names: true)

      expect(vendors[:data].count).to eq(5)

      vendors[:data].each do |vendor|
        expect(vendor).to have_key(:id)
        expect(vendor[:id]).to be_a(String)

        expect(vendor).to have_key(:type)
        expect(vendor[:type]).to eq("vendor")

        expect(vendor).to have_key(:attributes)
        expect(vendor[:attributes]).to be_a(Hash)

        attributes = vendor[:attributes]

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
    end

    it 'sad path' do
      expect Market.count == 0

      get '/api/v0/markets/1/vendors'

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      data = JSON.parse(response.body, symbolize_names: true)
      
      expect(data[:errors]).to be_a(Array)
      expect(data[:errors].first[:detail]).to eq("Couldn't find Market with 'id'=1")
    end
  end
end
