class Api::V0::MarketVendorsController < ApplicationController
  def create
    market_vendor = MarketVendor.new(market_vendor_params)

    if market_vendor.save
      render json: { message: "Successfully added vendor to market" }, status: :created
    else
      bad_request_response(market_vendor.errors.full_messages)
    end
  end

  private

  def market_vendor_params
    params.permit(:vendor_id, :market_id)
  end
end