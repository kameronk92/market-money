require "rails_helper"

RSpec.describe "Market Vendor Post Requests" do
  it "can create a new market vendor, happy" do
    market = create(:market)
    vendor = create(:vendor)

    post api_v0_market_vendors_path, params: { vendor_id: vendor.id, market_id: market.id }

    expect(response).to be_successful
    expect(response.status).to eq(201)

    expect(MarketVendor.count).to eq(1)
    
    market_vendor = JSON.parse(response.body, symbolize_names: true)

    expect(market_vendor).to have_key(:message)
    expect(market_vendor[:message]).to eq("Successfully added vendor to market")
  end

  it "can create a new market vendor, no market sad" do
    expect(Market.count).to eq(0)
    vendor = create(:vendor)

    post api_v0_market_vendors_path, params: { vendor_id: vendor.id, market_id: 1 }

    expect(response).to_not be_successful
    expect(response.status).to eq(404)

    expect(MarketVendor.count).to eq(0)
    
    market_vendor = JSON.parse(response.body, symbolize_names: true)

    expect(market_vendor).to have_key(:errors)
    expect(market_vendor[:errors][0][:detail]).to eq("Validation failed: Market must exist")
  end

  it "can create a new market vendor, association exists sad" do
    expect(Market.count).to eq(0)
    vendor = create(:vendor)
    market = create(:market)

    market.vendors << vendor
    expect(MarketVendor.count).to eq(1)

    post api_v0_market_vendors_path, params: { vendor_id: vendor.id, market_id: market.id }

    expect(response).to_not be_successful
    expect(response.status).to eq(422)

    expect(MarketVendor.count).to eq(1)
    
    market_vendor = JSON.parse(response.body, symbolize_names: true)

    expect(market_vendor).to have_key(:errors)
    expect(market_vendor[:errors][0][:detail]).to eq("Validation failed: Market vendor asociation between market with market_id=#{market.id} and vendor_id=#{vendor.id} already exists")
  end
end