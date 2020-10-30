FactoryBot.define do
  factory :savings_record do
    association :user
    earned_time { 120 }
    savings_date { Date.today }
    savings_name { "test_savings" }
  end

  factory :savings_record_other, class: SavingsRecord do
    association :user
    earned_time { 60 }
    savings_date { Date.today }
    savings_name { "test_savings" }
  end
end
