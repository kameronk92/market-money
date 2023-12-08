class Api::V0::MarketVendorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :bad_request_response

  def create
    market = Market.find(params[:market_id])
    raise ActiveRecord::RecordNotFound if market.nil?
    vendor = Vendor.find(params[:vendor_id])
    raise ActiveRecord::RecordNotFound if vendor.nil?

    raise ActiveRecord::RecordInvalid if market.vendors.include?(vendor)
   
    market.vendors << vendor
    render json: { message: "Successfully added vendor to market" }, status: :created
  end

  def destroy
    market_vendor = MarketVendor.find_by!(market_vendor_params)
    raise ActiveRecord::RecordNotFound if market_vendor.nil?
    MarketVendor.delete(market_vendor)
    render status: 204
  end

  private

  def not_found_response(exception)
    if params[:action] == "create"
      render json: {
          errors: [
            {
              detail: "Validation failed: Market must exist"
            }
          ]
        }, status: :not_found
    else params[:action] == "destroy"
      render json: {
        errors: [
          {
            detail: "No MarketVendor with market_id=#{params[:market_vendor][:market_id]} AND vendor_id=#{params[:market_vendor][:vendor_id]} exists"
          }
        ]
      }, status: :not_found
    end
  end

  def bad_request_response(exception)
    render json:{
      errors: [
          {
              detail: "Validation failed: Market vendor asociation between market with market_id=#{params[:market_id]} and vendor_id=#{params[:vendor_id]} already exists"
          }
      ]
    }, status: :unprocessable_entity
  end

  def market_vendor_params
    params.permit(:id, :vendor_id, :market_id)
  end
end