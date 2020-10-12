FactoryBot.define do
  factory :undone_action do
    association :user
    action_name { "test_action" }
    default_time { 120 }
  end

  factory :undone_action_other, class: UndoneAction do
    association :user
    action_name { "test_action" }
    default_time { 60 }
  end
end
