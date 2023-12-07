require 'rails_helper'

RSpec.describe "Market Vendor Delete Requests" do
  xit "can delete a market vendor, happy" do
    market = create(:market)
    vendor = create(:vendor)
    market.vendors << vendor

    expect(MarketVendor.count).to eq(1)

    delete api_v0_market_vendor_path(market.id, vendor.id)

    expect(response).to be_successful
    expect(response.status).to eq(204)

    expect(MarketVendor.count).to eq(0)
  end
  xit "can delete a market vendor, sad" do
    expect(MarketVendor.count).to eq(0)

    delete api_v0_market_vendor_path(4233, 11520)

    expect(response).to_not be_successful
    expect(response.status).to eq(404)

    expect(MarketVendor.count).to eq(0)

    market_vendor = JSON.parse(response.body, symbolize_names: true)

    expect(market_vendor).to have_key(:errors)
    expect(market_vendor[:errors][0][:detail]).to eq("No MarketVendor with market_id=4233 AND vendor_id=11520 exists")
  end
end