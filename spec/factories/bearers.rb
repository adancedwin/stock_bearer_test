# frozen_string_literal: true

FactoryBot.define do
  factory :bearer do
    name { Faker::Lorem.word }
  end
end
