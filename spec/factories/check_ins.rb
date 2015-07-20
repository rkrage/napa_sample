FactoryGirl.define do
  factory :check_in do
    user
    sequence(:name) { Faker::Company.name }
    sequence(:message) { Faker::Company.bs }
  end

  factory :check_in_with_coordinates, class: :check_in do
    user
    sequence(:name) { Faker::Company.name }
    sequence(:message) { Faker::Company.bs }
    sequence(:lat) { Faker::Address.latitude }
    sequence(:lng) { Faker::Address.longitude }
  end
end
