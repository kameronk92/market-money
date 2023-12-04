class Api::V0::MarketsController < ApplicationController
  def index
    @market = Market.all
  end
end
