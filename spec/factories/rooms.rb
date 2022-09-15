FactoryBot.define do
  factory :room do
    overnight_kind { "Room" }
    total_room { 1 }
    total_bed { 2 }
    has_air_con { true }
    has_kitchen { false }
    has_bath { true }
    has_wifi { true }
    price { 1000.0 }
    building 
  end
end
