class FetchBookingService
  def self.call(booking_number)
    client = HTTPClient.new
    response = client.get Settings.fetch_booking_url, { booking_number: booking_number }

    raise InvalidBookingException, I18n.t(:booking_expired) if response.status == 404

    parse(response)
  end
private

  def self.parse(response)
    result = JSON.parse(response.content)
    Booking.new(result)
  end
end
