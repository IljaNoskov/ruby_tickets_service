# frozen_string_literal: true

# Исключение, возникающее при передаче некоретных данных посетителя
class VisitorRegistrationException < RuntimeError
  attr_reader :response

  def initialize(response)
    super
    @response = response
  end
end
