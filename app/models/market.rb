class Market < ApplicationRecord
  has_many :market_vendors
  has_many :vendors, through: :market_vendors

  validates :name, :street, :city, :county, :state, :zip, :lat, :lon, presence: true
end
