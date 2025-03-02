FactoryBot.define do
  factory :article do
    title { Faker::Book.title }
    slug { title.parameterize }
    excerpt { Faker::Lorem.paragraph }
    feature_image { Faker::Internet.url }
    uuid { SecureRandom.uuid }
    published_at { Time.current }
    
    trait :with_tags do
      after(:create) do |article|
        article.tags << create(:tag)
      end
    end
  end
end
