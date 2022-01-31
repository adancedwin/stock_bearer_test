FactoryBot.define do
  factory :stock do
    name { Faker::Lorem.word }
    association :bearer
  end
end