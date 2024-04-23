class GrapeApi
  class VisitorsApi < Grape::API
    format :json

    namespace :visitors do

      namespace :validate do
        mount Validate
      end

      desc 'Создание нового посетителя или возвращение существующего с совпадающим документом',
      success: GrapeApi::Entities::Visitor, failure: [{ code: 400 }]
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
        result = CreateVisitorService.call params[:visitor]
        error!({ message: I18n.t(:uncorrect_params), errors: result.errors }, 400) unless result.successful?
        present result.visitor, with: GrapeApi::Entities::Visitor
      end

    end
  end
end
