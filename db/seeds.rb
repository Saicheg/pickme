DatabaseCleaner.clean_with :truncation

100.times do
  FactoryGirl.create :user
end

User.all.each do |user|
  FactoryGirl.create_list(:pick_weight_multiplier, 3, user: user)
end
