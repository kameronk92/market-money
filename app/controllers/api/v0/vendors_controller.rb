class Api::V0::VendorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response

  def index
    render json: VendorSerializer.new(Market.find(params[:market_id]).vendors)
  end

  def show
    render json: VendorSerializer.new(Vendor.find(params[:id]))
  end

  def create
    vendor = Vendor.new(vendor_params)

    if vendor.save
      render json: VendorSerializer.new(vendor), status: :created
    else
      bad_request_response(vendor.errors.full_messages)
    end
  end

  def update
    vendor = Vendor.find(params[:id])
    if vendor.update(vendor_params)
      render json: VendorSerializer.new(vendor), status: :accepted
    else
      bad_request_response(vendor.errors.full_messages)
    end
  end

  def destroy
    vendor = Vendor.find(params[:id])
    if vendor.destroy
      head :no_content
    else
      bad_request_response(vendor.errors.full_messages)
    end
  end

  private

  def vendor_params
    params.permit(:name, :description, :contact_name, :contact_phone, :credit_accepted)
  end
end