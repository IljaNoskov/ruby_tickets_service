# frozen_string_literal: true

class GrapeApi
  class PaymentApi < Grape::API
    format :json

    namespace :payment do
      route_param :id, type: Integer do
        get do
          payment = Payment.find_by(id: params[:id])
          error!({ message: I18n.t(:not_found) }, 404) unless payment
          present payment, with: GrapeApi::Entities::Payment
        end
      end

      mount CreatePaymentApi
    end
  end
end
