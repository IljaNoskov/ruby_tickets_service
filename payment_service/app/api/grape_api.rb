# frozen_string_literal: true

# Определяет API приложения
class GrapeApi < Grape::API
  mount PaymentApi
  add_swagger_documentation
end
