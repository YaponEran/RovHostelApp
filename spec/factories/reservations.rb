FactoryBot.define do
  factory :reservation do
    customer_user
    room
    start_at { "01.03.2022" }
    end_at { "01.05.2022" }
  end
end
