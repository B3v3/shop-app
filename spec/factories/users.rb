FactoryBot.define do
  factory :user do
    email { 'dejw@email.com' }
    password { 'rekinludojad' }
    password_confirmation { 'rekinludojad' }
  end

  factory :user1, class: User do
    email { 'dejws@email.com' }
    password { 'rekinludojad' }
    password_confirmation { 'rekinludojad' }
  end
end
