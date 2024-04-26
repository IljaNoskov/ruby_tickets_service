# frozen_string_literal: true

# Модель брони, получаемая от внешнего сервиса
class Booking
  include ActiveModel::Model

  attr_accessor :booking_number, :price, :ticket_type, :event_id, :status

  # метод получения id
  def id
    booking_number
  end

  # метод определения, хранится ли запись
  def persisted?
    false
  end
end
