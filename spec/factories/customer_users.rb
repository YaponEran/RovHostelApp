FactoryBot.define do
  factory :customer_user do
    sequence(:first_name) { |n| "CustomerTestname#{n}"}
    sequence(:last_name) { |n| "LastnameCus#{n}"}
    sequence(:mobile_phone) { |n| "+7(707)341-59-5#{n}"}
    sequence(:email) { |n| "custest#{n}@mail.ru"}
    password { "123456" } 
  end
end
