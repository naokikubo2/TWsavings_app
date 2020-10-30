FactoryBot.define do
    factory :user do
      sequence(:name) {|i| "User#{i}" }
      sequence(:email) {|i| "email#{i}@sample.com" }
      password { "password" }
      hourly_pay { "100" }
    end
  end
