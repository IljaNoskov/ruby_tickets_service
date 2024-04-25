class GrapeApi
  class CreatePaymentApi < Grape::API

    rescue_from InvalidBookingException, NotMeetRequirementsException  do |e|
      error!({ message: e.message }, 406)
    end

    rescue_from VisitorRegistrationException  do |e|
      error!(e.response, 406)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      error!({ message: I18n.t(:uncorrect_params), errors: e.record.errors }, 406)
    end

    params do
      requires :booking_number, type: String
      requires :visitor, type: Hash do
        requires :first_name, type: String
        requires :last_name, type: String
        optional :middle_name, type: String
        requires :birthdate, type: String
        requires :document_type, type: String
        requires :document_number, type: String
      end
    end
    post do
      booking = FetchBookingService.call(params[:booking_number])
      visitor = RegisterVisitorService.call(params[:visitor])

      ValidatePaymentRequestService.call(booking, visitor)
      payment = CreatePaymentTransactionService.call(booking, visitor)

      present payment, with: GrapeApi::Entities::Payment
    end

  end
end
