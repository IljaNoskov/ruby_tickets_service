class FetchBookingService
  def self.call(booking_number)
    client = HTTPClient.new
    response = client.get Settings.fetch_booking_url, { booking_number: booking_number }

    # raise ServiceUnavailableException, I18n.t(:booking_service_unavailable) if status > 500
    raise InvalidBookingException, I18n.t(:booking_expired) unless response.ok?

    parse(response)

  rescue HTTPClient::TimeoutError => _
    raise ServiceUnavailableException, I18n.t(:booking_service_unavailable)
  end
private

  def self.parse(response)
    result = JSON.parse(response.content)
    Booking.new(result)
  end
end
