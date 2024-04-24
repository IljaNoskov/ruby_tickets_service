class GrapeApi
  class PaymentApi < Grape::API
    format :json

    namespace :payment do
      route_param :id, type: Integer do
        #get
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

        present payment
      end
    end

  end
end
