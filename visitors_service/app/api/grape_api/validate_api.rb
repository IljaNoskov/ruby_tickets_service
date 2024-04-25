# frozen_string_literal: true

class GrapeApi
  class ValidateApi < Grape::API
    rescue_from ActiveRecord::RecordNotFound do |_e|
      error!({ message: I18n.t(:not_found) }, 404)
    end

    desc 'Проверка принадлежности документа пользователю',
         success: GrapeApi::Entities::ValidationResult, failure: [{ code: 404 }]
    params do
      requires :id, type: Integer
      requires :document_number, type: String
      optional :document_type, type: String
    end
    get :document do
      result = ValidateVisitorDocumentService.call(params[:id], params[:document_type], params[:document_number])
      present result, with: GrapeApi::Entities::ValidationResult
    end

    desc 'Проверка факта достижения посетителем требуемого возраста',
         success: GrapeApi::Entities::ValidationResult, failure: [{ code: 404 }]
    params do
      requires :id, type: Integer
      requires :age, type: Integer
    end
    get :age do
      result = ValidateVisitorAgeService.call(params[:id], params[:age])
      present result, with: GrapeApi::Entities::ValidationResult
    end
  end
end
