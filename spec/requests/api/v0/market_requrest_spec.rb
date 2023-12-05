require 'rails_helper'

describe "Markets API" do
  it "returns all markets" do
    create_list(:market, 10)

    get '/api/v0/markets'

    expect(response).to be_successful

    parsed_response = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_response).to be_an(Array)
    expect(parsed_response.first).to be_a(Hash)
    expect(parsed_response.first).to have_key(:name)
    expect(parsed_response.first[:name]).to be_a(String)
  end
end