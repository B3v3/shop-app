FactoryBot.define do
  factory :order do
    user_id { 1 }
    status { "In progress"}
    total_price { 0 }
  end
end
