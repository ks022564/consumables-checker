FactoryBot.define do
  factory :user do
    association :company
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    company_name { company.company_name }
  end
end
