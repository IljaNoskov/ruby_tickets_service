class GrapeApi
  class PaymentApi < Grape::API
    format :json

    namespace :payment do
      route_param :id, type: Integer do
        #get
      end

      mount CreatePaymentApi
    end

  end
end
