class Api::V0::SearchController < ApplicationController
  def search
    if params[:city] && !params[:state]
      render json: {
        "errors": [
            {
                "detail": "Invalid set of parameters. Please provide a valid set of parameters to perform a search with this endpoint."
            }
        ]
      }, status: 422
    else
      render json: MarketSerializer.new(Market.search(params[:state], params[:city], params[:name]))
    end
  end
end