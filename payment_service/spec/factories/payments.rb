FactoryBot.define do
  factory :payment do
    visitor_id { 1 }
    price { 1 }
    status { "MyString" }
    booking_number { "MyString" }
    event_id { 1 }
  end
end
