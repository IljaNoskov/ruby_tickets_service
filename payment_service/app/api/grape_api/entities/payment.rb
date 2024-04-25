# frozen_string_literal: true

class GrapeApi
  module Entities
    # Описывает представление платежной транзакции, возвращаемое пользователю
    class Payment < Grape::Entity
      expose :id, documentation: { type: 'Integer', desc: 'Идентификатор транзакции', required: true }
      expose :booking_number, documentation: { type: 'String', desc: 'Номер брони', required: true }
      expose :event_id, documentation: { type: 'Integer', desc: 'Идентификатор мероприятия', required: true }
      expose :visitor_id, documentation: { type: 'Integer', desc: 'Идентификатор посетителя', required: true }
      expose :ticket_id, documentation: { type: 'Integer', desc: 'Идентификатор билета', required: true }
      expose :price, documentation: { type: 'Integer', desc: 'Стоимость билета', required: true }
      expose :status, documentation: { type: 'String', desc: 'Статус транзакции', required: true }
    end
  end
end
