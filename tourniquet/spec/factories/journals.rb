FactoryBot.define do
  factory :journal do
    ticket_id { 1 }
    visitor { 1 }
    time { "2024-04-20 15:13:31" }
    action { "MyString" }
    status { "MyString" }
  end
end
