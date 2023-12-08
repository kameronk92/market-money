class Atm
  attr_reader :id, :name, :address, :lat, :lng, :distance

  def initialize(data)
    @id = data[:id]
    @name = data[:poi][:name]
    @address = data[:address][:freeformAddress]
    @lat = data[:position][:lat]
    @lon = data[:position][:lon]
    @distance = data[:dist]
  end
end