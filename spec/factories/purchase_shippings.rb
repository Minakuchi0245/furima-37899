FactoryBot.define do
  factory :purchase_shipping do
    postal_code {"111-1111"}
    prefectures_id { 2 }
    city {Faker::Address.city}
    address {Faker::Address.street_address}
    building_name {"建物"}
    telephone {Faker::Number.decimal_part(digits: 11)} 
  end
end
