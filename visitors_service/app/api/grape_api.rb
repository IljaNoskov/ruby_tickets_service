# frozen_string_literal: true

class GrapeApi < Grape::API
  mount VisitorsApi
  add_swagger_documentation
end
