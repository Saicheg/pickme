# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :boost do
    duration { 1.hour }
  end
end
