FactoryBot.define do
  factory :item do
    item_name { Faker::Name.initials(number: 40) }
    item_instruction { Faker::Lorem.sentence }
    category_id { 2 }
    condition_id { 2 }
    shipping_charge_id { 2 }
    shipping_area_id { 2 }
    shipping_days_id { 2 }
    price { 1000 }
    image { 'sample1.png' }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('spec/sample1.png'), filename: 'sample1.png')
    end
  end
end
