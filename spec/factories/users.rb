FactoryBot.define do
  factory :user do
    sequence(:user_name) { |n| "TEST_USER_NAME#{n}"}
    sequence(:full_name) { |n| "TEST_FULL_NAME#{n}"}
    sequence(:password)  { "515253"}
  end
end
