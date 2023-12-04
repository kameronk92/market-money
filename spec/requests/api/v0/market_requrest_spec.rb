require 'rails_helper'

describe "Markets API" do
  it "returns all markets" do
    create_list(:market, 10)

    get '/api/v0/markets'

    expect(response).to be_successful
    parsed_response = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_response).to be_a(Hash)
    expect(parsed_response).to have_key('market')
    expect(parsed_response['market']).to be_a(string)
  end
end