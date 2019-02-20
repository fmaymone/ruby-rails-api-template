FactoryBot.define do
  factory :trip do
    title { Faker::Lorem.word }
    start_at{ Faker::Date.forward(23) }
    end_at{ Faker::Date.forward(23) }
    comment { Faker::Lorem.word }
  end
end
