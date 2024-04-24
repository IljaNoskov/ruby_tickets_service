FactoryBot.define do
  factory :visitor do
    first_name { 'Имя' }
    last_name { 'Фамилия' }
    middle_name { 'Отчество' }
    document_type { 'passport' }
    document_number { '1234123456' }
    birthdate { Date.new(2000, 12, 29) }
  end
end
