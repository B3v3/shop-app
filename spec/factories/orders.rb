FactoryBot.define do
  factory :order do
    status { "In progress"}
    total_price { 0 }
  end
end
