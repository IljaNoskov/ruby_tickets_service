# frozen_string_literal: true

class GrapeApi
  module Entities
    # представление результата проверки, возвращаемое пользователю
    class ValidationResult < Grape::Entity
      expose :result, documentation: { type: 'Boolean', desc: 'Результат проверки', required: true }
      expose :visitor, with: GrapeApi::Entities::Visitor,
                       documentation: { type: 'Json', desc: 'Данные проверяемого пользователя', required: true }
    end
  end
end
