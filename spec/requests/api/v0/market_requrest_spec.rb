require 'rails_helper'

describe "Markets API" do
  it "returns all markets" do

    get '/api/v0/markets'

    expect(response).to be_successful
  end
end