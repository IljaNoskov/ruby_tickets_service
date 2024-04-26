class BookingControlJob
  include Sidekiq::Job

  def perform(booking_number)
    booking = Booking.find_by(booking_number: booking_number)
    return if booking.nil?
    booking.status == 'reserved' ? booking.destroy : booking
  end
end
