class Market < ApplicationRecord
  has_many :market_vendors, dependent: :destroy
  has_many :vendors, through: :market_vendors

  validates :name, :street, :city, :county, :state, :zip, :lat, :lon, presence: true

  def self.search(state, city, name)
    Market.where("markets.state ILIKE '%#{state}%' AND markets.city ILIKE '%#{city}%' AND markets.name ILIKE '%#{name}%'")
  end

  def nearest_atms_search
    conn = Faraday.new(url: "https://api.tomtom.com") do |faraday|
      faraday.params['key'] = Rails.application.credentials.TomTom[:key]
    end

    endpoint = "/search/2/categorySearch/ATM.json?limit=20&lat=#{self.lat.to_f.round(4)}&lon=#{self.lon.to_f.round(4)}&categorySet=7397"

    response = conn.get(endpoint)
    json = JSON.parse(response.body, symbolize_names: true)
    
    json[:id] = self.id
    
    @atms = json[:results].map do |result|
      Atm.new(result)
    end
  end
end
