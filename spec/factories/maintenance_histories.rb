FactoryBot.define do
  factory :maintenance_history do
    exchange_date          { Faker::Date.backward(days: rand(1..1000)) }
    next_maintenance_day   { Faker::Date.forward(days: rand(1..1000)) }
    worker                 { Faker::Name.name }
    maintenance_comment    { Faker::Lorem.sentence }
    association :user
    association :item
  end
end
