class CreatePaymentTransactionService
  def self.call(booking, visitor)
    Payment.create!(
      visitor_id: visitor.id,
      booking_number: booking.booking_number,
      event_id: booking.event_id,
      price: booking.price,
      status: 'processing'
    )
  end
end
