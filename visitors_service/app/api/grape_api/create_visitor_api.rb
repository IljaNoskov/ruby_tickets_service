# frozen_string_literal: true

class GrapeApi
  # определяет api для создания посетителя
  class CreateVisitorApi < Grape::API
    rescue_from ActiveRecord::RecordInvalid do |e|
      error!({ message: I18n.t(:uncorrect_params), errors: e.record.errors }, 406)
    end

    desc 'Создание нового посетителя или возвращение существующего с совпадающим документом',
         success: GrapeApi::Entities::Visitor, failure: [{ code: 406 }]
    params do
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
      visitor = CreateVisitorService.call params[:visitor]
      status 201
      present visitor, with: GrapeApi::Entities::Visitor
    end
  end
end
