class GrapeApi < Grape::API
  mount PaymentApi
  add_swagger_documentation
end
