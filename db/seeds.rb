50.times do
  trip = Trip.create(destination: Faker::Nation.capital_city, user: User.first, start_date: Faker::Date.forward(100))
end