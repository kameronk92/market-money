class MarketsController < ApplicationController
  def index
    @market = Market.all
  end
end