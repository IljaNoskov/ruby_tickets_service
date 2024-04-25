# frozen_string_literal: true

class GrapeApi
  # Определяет API для управления платежными транзакциями
  class PaymentApi < Grape::API
    format :json

    namespace :payment do
      route_param :id, type: Integer do

        desc 'Поиск платежной транзакции',
        success: GrapeApi::Entities::Payment, failure: [{ code: 404, message: I18n.t(:not_found) }]
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
