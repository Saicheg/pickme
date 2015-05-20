# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :boost do
    duration { 1.hour }

    factory :pick_weight_multiplier, class: Boosts::PickWeightMultiplier do
      multiplier 3
    end
  end
end
