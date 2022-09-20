FactoryBot.define do
  factory :building do
    sequence(:build_title) { |n| "Building_#{n}"}
    sequence(:build_postcode) { |n| "003000#{n}"}
    sequence(:address) { |n| "City Almaty room_#{n}"}
    sequence(:phone_number) { |n| "+7(707)000-00-0#{n}"}
    hotel
  end
end
