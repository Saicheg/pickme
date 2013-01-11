FactoryGirl.define do
  factory :user do
    vk_id { rand 10_000_000 }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    nickname { Faker::Lorem.words 1 }
    screen_name { Faker::Lorem.words 1 }
    sex { [:male, :female].sample }
    bdate { 10.years.ago - rand(10_000_000) }
    city { Faker::Address.city }
    country { Faker::Address.country }
    rating { random 100 }
  end
end
