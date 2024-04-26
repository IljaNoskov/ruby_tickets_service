class GrapeApi 
  class CreateBookingsApi < Grape::API
    format :json
    namespace :bookings do
      params do 
        requires :event_id, type: Integer, desc: 'ID of event'
        requires :type, type: String, desc: 'Type of ticket (vip/ordinary)'
        requires :date, type: Date, desc: 'Date of event'
      end
      post do
        booking = Booking.new
        client = HTTPClient.new
        uri = ENV['TICKETS_URL']
        body = { action: 'create', event_id: params[:event_id], type: params[:type] }
        response = client.put(uri, body)
        ticket = JSON.parse(response.body)
        if response.status == 201
          booking = Booking.new(
            ticket_type: params[:type], 
            event_id: params[:event_id], 
            booking_number: SecureRandom.uuid, 
            status: 'reserved',
            ticket_id: ticket['id'],
            price: ticket['price']
          )
          error!({ message: 'something goes wrong' }, 406) unless booking
          booking.save
          BookingControlJob.perform_in(5.minute, booking.booking_number)
        else 
          { message: 'ticket already reserved', status: 406 }
        end
        present booking, with: GrapeApi::Entities::Booking
      end
    end
  end
end