class GrapeApi
  class DeleteBookingsApi < Grape::API
    format :json
    namespace :bookings do
      params do
        requires :booking_number, type: String, desc: 'Number of booking'
        optional :visitor_id, type: Integer, desc: 'User id'
      end
      delete do
        booking = DeleteBookingsSevice(params)
        present booking
      end
    end 
  end
end