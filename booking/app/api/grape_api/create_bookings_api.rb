class GrapeApi
  class CreateBookingsApi < Grape::API
    format :json
    namespace :bookings do
      params do
        requires :event_id, type: Integer, desc: 'ID of event'
        requires :type, type: String, desc: 'Type of ticket (vip/ordinary)'
        requires :date, type: Date, desc: 'Date of event'
      end
      post do
        booking = CreateBookingsService.call(params)
        present booking, with: GrapeApi::Entities::Booking
      end
    end
  end
end
