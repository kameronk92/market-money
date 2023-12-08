require "rails_helper"

RSpec.describe "ATM Search Requests" do
  VCR.use_cassette('atm_search') do
    it "can search for an ATM, happy" do
      market = create(:market, id: 1)

      get '/api/v0/markets/1/nearest_atms'

      expect(response).to be_successful
      expect(response.status).to eq(200)
      
      atms = JSON.parse(response.body, symbolize_names: true)
      
      expect(atms).to be_a(Hash)
      expect(atms[:data]).to be_an(Array)
      expect(atms[:data].first).to have_key(:id)
      expect(atms[:data].first).to have_key(:attributes)
    end
  end
end