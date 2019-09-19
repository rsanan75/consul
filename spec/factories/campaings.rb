FactoryBot.define do
  factory :campaing do
    sequence(:title)       { |n| "#{Faker::Lorem.sentence} #{n}" }
    sequence(:description) { |n| "#{Faker::Lorem.paragraph} #{n}" }
    starts_at              { 6.months.ago }
    ends_at                { 6.months.from_now }
  end
end
