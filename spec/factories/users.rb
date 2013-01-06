FactoryGirl.define do
  sequence(:email) { |i| "email#{i}@example.com" }

  factory :user do
    email
    name { Faker::Name.name }
  end
end
