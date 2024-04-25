# frozen_string_literal: true

# сервис проверки возраста посетителя
class ValidateVisitorAgeService
  def self.call(id, age)
    visitor = Visitor.find(id)

    lowest_date = visitor.birthdate.advance(years: age)
    result = Date.current >= lowest_date

    VisitorValidationResult.new(result, visitor)
  end
end
