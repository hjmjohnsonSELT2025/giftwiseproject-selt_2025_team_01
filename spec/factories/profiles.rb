FactoryBot.define do
  factory :profile do
    user { nil }
    name { "MyString" }
    age { 1 }
    occupation { "MyString" }
    hobbies { "MyText" }
    likes { "MyText" }
    dislikes { "MyText" }
  end
end
