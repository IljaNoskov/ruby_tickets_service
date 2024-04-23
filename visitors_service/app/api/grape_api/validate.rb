class GrapeApi
  class Validate < Grape::API
    params do
      requires :id, type: Integer
      requires :document_number, type: String
      optional :document_type, type: String
    end
    get do

    end

    params do
      requires :id, type: Integer
      requires :age, type: Integer
    end
    get do
    end

  end
end
