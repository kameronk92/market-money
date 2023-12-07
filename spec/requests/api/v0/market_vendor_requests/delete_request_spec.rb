require 'rails_helper'

RSpec.describe "Market Vendor Delete Requests" do
  it "can delete a market vendor, happy" do
    market = create(:market)
    vendor = create(:vendor)
    market.vendors << vendor
    expect(MarketVendor.count).to eq(1)
    market_vendor_params = ({
                    market_id: market.id,
                    vendor_id: vendor.id
                  })
    headers = {'CONTENT_TYPE' => 'application/json'}

    delete '/api/v0/market_vendors', headers: headers, params: JSON.generate(market_vendor: market_vendor_params)

    expect(response).to be_successful
    expect(response.status).to eq(204)

    expect(MarketVendor.count).to eq(0)
  end
  
  it "can delete a market vendor, sad" do

    expect(MarketVendor.count).to eq(0)
    market = create(:market)

    market_vendor_params = ({
      market_id: 4233,
      vendor_id: 11520
    })
    headers = {'CONTENT_TYPE' => 'application/json'}

    delete '/api/v0/market_vendors', headers: headers, params: JSON.generate(market_vendor: market_vendor_params)

    expect(response).to_not be_successful
    expect(response.status).to eq(404)

    expect(MarketVendor.count).to eq(0)

    market_vendor = JSON.parse(response.body, symbolize_names: true)

    expect(market_vendor).to have_key(:errors)
    expect(market_vendor[:errors][0][:detail]).to eq("No MarketVendor with market_id=4233 AND vendor_id=11520 exists")
  end
end