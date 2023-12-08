class Market < ApplicationRecord
  has_many :market_vendors, dependent: :destroy
  has_many :vendors, through: :market_vendors

  validates :name, :street, :city, :county, :state, :zip, :lat, :lon, presence: true

  def self.search(state, city, name)
    Market.where("markets.state ILIKE '%#{state}%' AND markets.city ILIKE '%#{city}%' AND markets.name ILIKE '%#{name}%'")
  end
end
