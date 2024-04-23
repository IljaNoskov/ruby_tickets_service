class GrapeApi
  module Entities
    class ValidationResult < Grape::Entity
      expose :result, documentation: { type: 'Boolean', desc: 'Результат проверки', required: true }
      expose :visitor, with: GrapeApi::Entities::Visitor, documentation: { type: 'Json', desc: 'Данные проверяемого пользователя', required: true }
    end
  end
end
