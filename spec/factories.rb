require "factory_bot"

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
  end

  factory :playlist do
    user
    name { Faker::Lorem.sentence(word_count: 3) }
  end

  factory :video do
    title { Faker::Lorem.sentence(word_count: 3) }
    external_ref { Faker::Alphanumeric.alpha(number: 10) }
  end

  factory :playlist_entry do
    video
    playlist
  end
end
