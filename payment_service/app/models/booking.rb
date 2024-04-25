# frozen_string_literal: true

class Booking
  include ActiveModel::Model

  attr_accessor :booking_number, :price, :ticket_type, :event_id, :status

  def id
    booking_number
  end

  def persisted?
    false
  end
end
