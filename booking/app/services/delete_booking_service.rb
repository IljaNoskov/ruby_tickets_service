class DeleteBookingsService 
  def self.call(params)
    booking = Booking.find_by(booking_number: params[:booking_number])
    error!({ message: 'booking not found' }, 404) unless booking
    client = HTTPClient.new
    uri = ENV['TICKETS_URL']
    params[:visitor_id].nil? ? body = { ticket_id: booking.ticket_id, action: 'delete' } : body = { ticket_id: booking.ticket_id, action: 'buy', user_id: params[:visitor_id] }
    response = client.put(uri, body)
    params[:visitor_id].nil? ? body = 'deleted' : body = JSON.parse(response.body)
    if response.status == 201
      booking.destroy
      { status: 204, body: body}
    else
      { message: 'Something goes wrong' }
    end
  end
end