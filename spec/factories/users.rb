FactoryBot.define do
  factory :user do
    name { 'Example User' }
    email { 'user@example.com' }
    password { 'foobar' }
    password_confirmation { 'foobar' }
    admin { 'true' }
  end

  factory :other, class: User do
    name { 'michael' }
    email { 'michael@example.com' }
    password { 'foobar' }
    password_confirmation { 'foobar' }
  end

  factory :sample, class: User do
    sequence(:name) { |i| "user_#{i}" }
    sequence(:email) { |i| "user-#{i}@example.com" }
    password { 'foobar' }
    password_confirmation { 'foobar' }
  end
end
