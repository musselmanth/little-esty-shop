FactoryBot.define do

  factory :invoice_item do
    item
    invoice
    quantity {rand(1..500)}
    unit_price { rand(100..15000) }
    status { rand(3) }
  end

  factory :transaction do
    invoice
    credit_card_number { rand(1000000000000000..9999999999999999) }
    result { rand(2) }
  end

  factory :invoice do
    customer
    status { rand(3) }
  end

  factory :item do 
    merchant
    name {Faker::Commerce.product_name }
    description { Faker::Quote.yoda }
    unit_price { rand(100..15000) }
  end

  factory :customer do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
  end

  factory :merchant do
    name { Faker::Company.name}
  end

  factory :bulk_discount do
    merchant
    threshold { 10 }
    discount { 15 }
  end
  
end