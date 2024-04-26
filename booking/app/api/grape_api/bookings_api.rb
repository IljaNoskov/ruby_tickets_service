require_relative '../../sidekiq/booking_control_job.rb'
require 'securerandom'

class GrapeApi
  class BookingsApi < Grape::API
    format :json
    namespace :bookings do
      params do 
        requires :booking_number, type: String
      end
      get do 
        booking = Booking.find_by(booking_number: params[:booking_number])
        error!({ message: 'Unavailable booking number' }, 404) unless booking
        present booking, with: GrapeApi::Entities::Booking
      end
    end
  end
end