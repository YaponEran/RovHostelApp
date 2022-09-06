FactoryBot.define do
  factory :hotel do
    sequence(:title) { |n| "Hotel_#{n}"}
    sequence(:adress) { |n| "City Almaty room_#{n}"}
    sequence(:postcode) { |n| "003000#{n}"}
    sequence(:phone_number) { |n| "+7(707)000-00-0#{n}"}
    user
  end
end
