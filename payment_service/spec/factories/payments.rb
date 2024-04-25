# frozen_string_literal: true

FactoryBot.define do
  factory :payment do
    visitor_id { 1 }
    price { 1000 }
    status { 'finished' }
    booking_number { '123' }
    event_id { 1 }
  end
end
