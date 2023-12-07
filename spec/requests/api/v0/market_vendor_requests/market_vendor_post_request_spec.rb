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

    expect(market_vendor).to have_key(:data)
    expect(market_vendor[:message]).to eq("Successfully added vendor to market")
  end
end