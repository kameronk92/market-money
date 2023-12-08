require 'rails_helper'

RSpec.describe "Markets Show Requests" do
  it "sends details of a single market, happy" do
    market = create(:market)

    get api_v0_market_path(market.id)

    expect(response).to be_successful
    expect(response.status).to eq(200)

    market = JSON.parse(response.body, symbolize_names: true)

    expect(market).to have_key(:data)
    expect(market[:data]).to be_a(Hash)

    expect(market[:data]).to have_key(:id)
    expect(market[:data][:id]).to be_a(String)
    
    expect(market[:data]).to have_key(:type)
    expect(market[:data][:type]).to eq("market")

    expect(market[:data]).to have_key(:attributes)
    expect(market[:data][:attributes]).to be_a(Hash)

    attributes = market[:data][:attributes]

    expect(attributes).to have_key(:name)
    expect(attributes[:name]).to be_a(String)

    expect(attributes).to have_key(:street)
    expect(attributes[:street]).to be_a(String)

    expect(attributes).to have_key(:city)
    expect(attributes[:city]).to be_a(String)
    
    expect(attributes).to have_key(:county)
    expect(attributes[:county]).to be_a(String)

    expect(attributes).to have_key(:state)
    expect(attributes[:state]).to be_a(String)
    
    expect(attributes).to have_key(:zip)
    expect(attributes[:zip]).to be_a(String)
    
    expect(attributes).to have_key(:lat)
    expect(attributes[:lat]).to be_a(String)

    expect(attributes).to have_key(:lon)
    expect(attributes[:lon]).to be_a(String)

    expect(attributes).to have_key(:vendor_count)
    expect(attributes[:vendor_count]).to be_a(Integer) 
  end

  it "sends details of a single market, sad" do
    expect Market.count == 0

    get api_v0_market_path(1)

    expect(response).to_not be_successful
    expect(response.status).to eq(404)

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data[:errors]).to be_an(Array)
    expect(data[:errors].first[:detail]).to eq("Couldn't find Market with 'id'=1")
  end
end
