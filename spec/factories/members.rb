FactoryBot.define do
  factory :member do
    sequence(:first_name) {|n| "TEST_NAME#{n}"}
    sequence(:last_name)  {|n| "TEST_NAME#{n}"}
    sequence(:email)  {|n| "TEST#{n}@example.com"}
    sequence(:encrypted_password) {"111111"}
    sequence(:password_confirmation) {"111111"}
  end
end