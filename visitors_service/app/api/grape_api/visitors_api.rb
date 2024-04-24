class GrapeApi
  class VisitorsApi < Grape::API
    format :json

    namespace :visitors do

      namespace :validate do
        mount ValidateApi
      end

      namespace do
        mount CreateVisitorApi
      end

    end
  end
end
