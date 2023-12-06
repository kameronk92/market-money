require 'rails_helper'

describe "Markets Index" do
  it "sends a list of all markets" do
    create_list(:market, 7)

    @vendors = create_list(:vendor, 20) 

    @vendors.each do |vendor|
      market = Market.all.sample
      vendor.markets << market
    end
 
    get api_v0_markets_path

    expect(response).to be_successful

    markets = JSON.parse(response.body, symbolize_names: true)

    expect(markets[:data].count).to eq(7)

    markets[:data].each do |market|
      expect(market).to have_key(:id)
      expect(market[:id]).to be_an(String)

      expect(market).to have_key(:attributes)
      expect(market[:attributes]).to be_a(Hash)

      expect(market[:attributes]).to have_key(:name)
      expect(market[:attributes][:name]).to be_a(String)

      expect(market[:attributes]).to have_key(:street)
      expect(market[:attributes][:street]).to be_a(String)

      expect(market[:attributes]).to have_key(:city)
      expect(market[:attributes][:city]).to be_a(String)

      expect(market[:attributes]).to have_key(:county)
      expect(market[:attributes][:county]).to be_a(String)

      expect(market[:attributes]).to have_key(:state)
      expect(market[:attributes][:state]).to be_a(String)

      expect(market[:attributes]).to have_key(:zip)
      expect(market[:attributes][:zip]).to be_a(String)

      expect(market[:attributes]).to have_key(:lat)
      expect(market[:attributes][:lat]).to be_a(String)
      
      expect(market[:attributes]).to have_key(:lon)
      expect(market[:attributes][:lon]).to be_a(String)
    end
  end

  it "sends details of a single market" do
    get api_v0_market_path(1)

    expect(response).to be_successful

    market = JSON.parse(response.body, symbolize_names: true)
  end
end
