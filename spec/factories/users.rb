FactoryBot.define do
  factory :user do
    sequence(:first_name) { |n| "Testname#{n}"}
    sequence(:last_name) { |n| "Lastname#{n}"}
    sequence(:mobile_phone) { |n| "+7(707)341-59-5#{n}"}
    sequence(:email) { |n| "test#{n}@mail.ru"}
    password { "123456" } 
    role
  end
end
