class Api::V0::VendorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response

  def index
    render json: VendorSerializer.new(Market.find(params[:market_id]).vendors)
  end
end