require "rails_helper"

RSpec.describe "Market Search Requests" do
  it "can search for a market, happy" do

    market = create(:market, state: 'Colorado', city: 'Denver', name: 'Pearl Street Market')
    market_2 = create(:market, state: 'California', city: 'Denver', name: 'Cherry Creek Farmers Market')

    market_search_params = {
        state: 'colora'
      }

    get '/api/v0/markets/search', params: market_search_params

    expect(response).to be_successful
    expect(response.status).to eq(200)

    results = JSON.parse(response.body, symbolize_names: true)

    expect(results[:data].count).to eq(1)
    expect(results[:data][0][:attributes][:name]).to eq(market.name)
    expect(results[:data]).to_not include(market_2.name)
  end

  it "can search for a market, sad" do
    market = create(:market, state: 'Colorado', city: 'Denver', name: 'Pearl Street Market')
    market_2 = create(:market, state: 'California', city: 'Denver', name: 'Cherry Creek Farmers Market')

    market_search_params = {
        city: 'D-town'
      }

    get '/api/v0/markets/search', params: market_search_params

    expect(response).to_not be_successful
    expect(response.status).to eq(422)

    results = JSON.parse(response.body, symbolize_names: true)

    expect(results[:errors][0][:detail]).to eq("Invalid set of parameters. Please provide a valid set of parameters to perform a search with this endpoint.")
  end
end