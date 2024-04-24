class GrapeApi
  class VisitorsApi < Grape::API
    format :json

    namespace :visitors do

      namespace :validate do
        mount ValidateApi
      end

      mount CreateVisitorApi

    end
  end
end
