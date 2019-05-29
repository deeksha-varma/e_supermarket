FactoryGirl.define do
  factory :category do
  	sequence(:name) { |n| "John#{n}" }
  end
end
