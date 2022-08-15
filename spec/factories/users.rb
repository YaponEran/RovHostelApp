FactoryBot.define do
  factory :user do
    first_name { "Rovshen" }
    last_name { "Gulamow" }
    mobile_phone { "+7(707)341-59-52" } 
    email { "test@mail.ru" }
    password { "123456" } 
    role
  end
end
