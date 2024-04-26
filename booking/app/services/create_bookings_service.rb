require_relative '../sidekiq/booking_control_job.rb'
require 'securerandom'

class CreateBookingsService
  def self.call(params)
    client = HTTPClient.new
    uri = ENV['TICKETS_URL']
    puts "передаю #{ENV['TICKETS_URL']}"
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
      booking
    else
      { message: response.body }
    end
  end
end
