FactoryBot.define do
  factory :individual do
    sequence(:title) { |n| "Almaty #{n} bars house" }
    sequence(:judicial_adress) { |n| "Almaty 23 #{n} street alfarabi room 102" }
    sequence(:postal_adress) { |n| "Almaty 12 #{n} street shewchenko room 103" }
    sequence(:phone) { |n| "+7(70#{n})341-52-51" }
    sequence(:email) { |n| "indi#{n}@mail.ru"}
    sequence(:personal_uuid) { |n| "8901#{n}"}
    sequence(:auth_token) { |n| "1234#{n}"}
  end
end
