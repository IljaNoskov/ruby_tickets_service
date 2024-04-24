require_relative '../../sidekiq/booking_control_job.rb'
require 'securerandom'

class GrapeApi
  class BookingsApi < Grape::API
    format :json
    namespace :bookings do 
      params do 
        requires :event_id, type: Integer, desc: 'ID of event'
        requires :ticket_type, type: String, desc: 'Type of ticket (vip/fan)'
        requires :date, type: Date, desc: 'Date of event'
      end
      post do
        booking = Booking.new(ticket_type: params[:ticket_type], event_id: params[:event_id], booking_number: SecureRandom.uuid, status: 'reserved')
        error!({ message: 'something goes wrong' }, 406) unless booking
        booking.save
        BookingControlJob.perform_in(5.minute, booking.booking_number)
        present booking, with: GrapeApi::Entities::Booking
      end

      params do 
        requires :booking_number, type: String, desc: 'Number of booking'
        requires :status, type: String, desc: 'Booking status'
      end
      put do
        booking = Booking.find_by(booking_number: params[:booking_number])
        error!({ message: 'Unavailable booking numver'}, 406) unless booking
        booking.update(status: params[:status])
        booking.status == 'reserved' ? BookingControlJob.perform_in(2.minute, params[:booking_number]) : booking
        { status: 200, message: 'Booking status was successfully updated' }
      end

      params do
        requires :booking_number, type: String, desc: 'Number of booking'
      end
      delete do
        booking = Booking.find_by(booking_number: params[:booking_number])
        error!({ message: 'booking not found' }, 404) unless booking
        booking.destroy
        { status: 204, message: 'Booking was successfully deleted' } 
      end

      params do 
        optional :booking_number, type: String
      end
      get do 
        booking = Booking.all
        booking = booking.where('booking_number == :booking_number', booking_number: params[:booking_number]) if params[:booking_number].present?
        present booking, with: GrapeApi::Entities::Booking
      end
    end
  end
end