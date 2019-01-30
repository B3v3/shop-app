FactoryBot.define do
  factory :product do
    name { 'bulbulator' }
    description { 'great tool, 10/10 '}
    price { 62 }
  end

  factory :product1, class: Product do
    name { 'uscisk dloni prezesa' }
    description { 'great pleasure, pure enlightning experience '}
    price { 500 }
  end
end
