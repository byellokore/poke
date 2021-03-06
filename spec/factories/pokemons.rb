FactoryBot.define do
  sequence :name do |n|
    "Poke#{n}"
  end

  factory :pokemon do
    name
    type_1 { "Normal" }
    type_2 { "Flying" }
    total { 350 }
    hp { 40 }
    attack { 49 }
    defense { 65 }
    sp_atk { 51 }
    sp_def { 41 }
    speed { 61 }
    generation { 1 }
    legendary { false }
  end
end
