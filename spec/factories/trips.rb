FactoryBot.define do
  factory :trip do
    destination { Faker::Lorem.word }
    start_at { Faker::Date.between(2.days.ago, Date.today) }
  end
end