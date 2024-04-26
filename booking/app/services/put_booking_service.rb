class PutBookingService
  def self.call(params)
    booking = Booking.find_by(booking_number: params[:booking_number])
    error!({ message: 'Unavailable booking number'}, 404) unless booking
    booking.status == 'reserved' ? booking.update(status: 'payment') : booking.update(status: 'reserved')
    booking.status == 'reserved' ? BookingControlJob.perform_in(2.minute, params[:booking_number]) : booking
    { status: 201, message: 'Booking status was successfully updated', body: booking }
  end
end