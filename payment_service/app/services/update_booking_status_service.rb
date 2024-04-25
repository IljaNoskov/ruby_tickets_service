# frozen_string_literal: true

# Сервис обновления статуса брони в соответсвии с результатом транзакции
class UpdateBookingStatusService
  # уведомление сервиса брони об успешной оплате
  def self.buy(booking_number)
    client = HTTPClient.new
    response = client.delete Settings.buy_booking_url, { booking_number: booking_number }

    # response.status == 404 ??? те билет оплачен, а брони нет, ноу вей
    # rescue
  end

  # уведомление сервиса брони об ошибке при оплате
  def self.invalidate(booking_number)
    client = HTTPClient.new
    response = client.put Settings.update_booking_status_url, { booking_number: booking_number }

    # 404?
    # rescue
  end
end
