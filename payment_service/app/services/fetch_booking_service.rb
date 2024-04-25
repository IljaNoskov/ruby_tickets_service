class FetchBookingService
  def self.call(booking_number)
    client = HTTPClient.new
    response = client.put Settings.update_booking_status_url, { booking_number: booking_number }

    # raise ServiceUnavailableException, I18n.t(:booking_service_unavailable) if status > 500
    raise InvalidBookingException, I18n.t(:booking_expired) unless response.ok?

    parse(response)
  rescue HTTPClient::TimeoutError => _e
    raise ServiceUnavailableException, I18n.t(:booking_service_unavailable)
  end

  def self.parse(response)
    result = JSON.parse(response.content)['body']
    Booking.new(result)
  end
end
