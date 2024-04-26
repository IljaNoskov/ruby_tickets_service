class GrapeApi
  module Entities
    class Booking < Grape::Entity
      expose :booking_number, documentation: { type: String, desc: 'Number of booking' }
      expose :price, documentation: { type: Integer, desc: 'Price of ticket' }
      expose :ticket_type, documentation: { type: String, desc: 'Type of ticket' }
      expose :event_id, documentation: { type: Integer, desc: 'ID of event' }
      expose :status, documentation: { type: String, desc: 'Booking status' }
    end
  end
end