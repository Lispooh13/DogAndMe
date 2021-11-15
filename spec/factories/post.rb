FactoryBot.define do
  factory :post do
    user_id {1}
    place { Faker::Lorem.characters(number:5) }
    address { Faker::Lorem.characters(number:20) }
    body { Faker::Lorem.characters(number:20) }
    category {0}
  end
end