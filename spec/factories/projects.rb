FactoryBot.define do
  factory :project do
    name { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
    logo { Rack::Test::UploadedFile.new('public/apple-touch-icon.png') }
    association :user

    trait :public do
      project_type { Project.project_types[:public_type] }
    end

    trait :private do
      project_type { Project.project_types[:private_type] }
    end
  end
end
