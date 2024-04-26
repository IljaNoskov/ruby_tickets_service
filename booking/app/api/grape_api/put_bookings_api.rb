class GrapeApi
  class PutBookingsApi < Grape::API
    format :json
    namespace :bookings do 
      params do 
        requires :booking_number, type: String, desc: 'Number of booking'
      end
      put do
        booking = PutBookingService.call(params)
        present booking
      end
    end
  end
end