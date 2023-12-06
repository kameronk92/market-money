require "rails_helper"

RSpec.describe "market serializer" do
  it "should include a correct name" do
    market = create(:market)
    serializer = MarketSerializer.new(market)
    expect(serializer.serializable_hash[:data][:attributes][:name]).to eq(market.name)
  end
end