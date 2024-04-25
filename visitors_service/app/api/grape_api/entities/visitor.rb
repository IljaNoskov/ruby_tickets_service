# frozen_string_literal: true

class GrapeApi
  module Entities
    class Visitor < Grape::Entity
      expose :id, documentation: { type: 'Integer', desc: 'Идентификатор посетителя', required: true }
      expose :first_name, documentation: { type: 'String', desc: 'Имя посетителя', required: true }
      expose :last_name, documentation: { type: 'String', desc: 'Фамилия посетителя', required: true }
      expose :middle_name, documentation: { type: 'String', desc: 'Отчество посетителя', required: false }
      expose :birthdate, documentation: { type: 'String', desc: 'Дата рождения', required: true }
    end
  end
end
