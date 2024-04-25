# frozen_string_literal: true

# Сервис обработки платежной транзакции
class StartPaymentTransactionService
  def self.call(booking, visitor)
    ValidatePaymentRequestService.call(booking, visitor)
    payment = CreatePaymentTransactionService.call(booking, visitor)

    UpdateBookingStatusService.buy(booking.booking_number)

    payment
  rescue RuntimeError => e
    UpdateBookingStatusService.invalidate(booking.booking_number)

    raise e
  end
end
