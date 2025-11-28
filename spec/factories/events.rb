FactoryBot.define do
  factory :event do
    user { nil }
    name { "MyString" }
    date { "2025-11-27" }
    description { "MyText" }
    theme { "MyString" }
    budget { "9.99" }
  end
end
