class Api::V0::MarketVendorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response

  def create
    market = Market.find(params[:market_id])
    vendor = Vendor.find(params[:vendor_id])

    if market.vendors << vendor
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