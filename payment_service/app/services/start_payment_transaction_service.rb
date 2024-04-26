# frozen_string_literal: true

# Сервис обработки платежной транзакции
class StartPaymentTransactionService
  # метод вызова сервиса
  def self.call(booking, visitor)
    ValidatePaymentRequestService.call(booking, visitor)
    payment = CreatePaymentTransactionService.call(booking, visitor)

    UpdateBookingStatusService.buy(booking.booking_number, visitor.id)

    payment
  rescue RuntimeError => e
    UpdateBookingStatusService.invalidate(booking.booking_number)

    raise e
  end
end
