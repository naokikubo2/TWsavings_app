FactoryBot.define do
  factory :comment do
    association :user
    association :savings_record
    sequence(:content) {|i| "Comment#{i}" }
  end
end
