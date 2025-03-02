FactoryBot.define do
  factory :tag do
    name { Faker::Book.genre }
    slug { name.parameterize }
  end
end
