FactoryBot.define do
  factory :item do
    consumable_name         { Faker::Commerce.product_name }
    consumable_model_number { Faker::Device.model_name }
    consumable_maker        { Faker::Company.name }
    equipment_name          { Faker::Appliance.brand }
    equipment_model_number  { Faker::Appliance.equipment }
    serial_number           { Faker::Device.serial }
    inspection_interval     { Faker::Number.between(from: 1, to: 365) }
    start_date              { Faker::Date.backward(days: 365) }
  end
end
