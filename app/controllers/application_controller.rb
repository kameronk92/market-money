class ApplicationController < ActionController::API
  def bad_request_response(exception, market_vendor = false)
    render json: ErrorSerializer.new(ErrorMessage.new(exception, 400))
    .serialize_json, status: :bad_request
  end

  def not_found_response(exception)
    render json: ErrorSerializer.new(ErrorMessage.new(exception.message))
    .serialize_json, status: :not_found
  end
end
