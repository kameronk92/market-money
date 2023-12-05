FactoryBot.define do
  factory :market do
    name { Faker::Commerce.vendor }
    street { Faker::Address.street_address }
    city { Faker::Address.city }
    county { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip { Faker::Address.zip }
    lat { Faker::Address.latitude }
    lon { Faker::Address.longitude }
  end
end
