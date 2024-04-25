class UpdateBookingStatusService
  def self.buy(booking_number)
    client = HTTPClient.new
    response = client.delete Settings.buy_booking_url, { booking_number: booking_number }

    # response.status == 404 ??? те билет оплачен, а брони нет, ноу вей
    # rescue
  end

  def self.invalidate(booking_number)
    client = HTTPClient.new
    response = client.put Settings.update_booking_status_url, { booking_number: booking_number }

    # 404?
    # rescue
  end
end
