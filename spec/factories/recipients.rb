FactoryBot.define do
  factory :recipient do
    association :user
    name { "MyString" }
  end
end
