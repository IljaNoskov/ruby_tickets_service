# frozen_string_literal: true

# сервис проверки принадлежности посетителю указанного документа
class ValidateVisitorDocumentService
  def self.call(id, document_type, document_number)
    number = PretifyDocumentNumberService.call(document_number)
    type = document_type || DetermineDocumentTypeService.call(number)

    visitor = Visitor.find(id)
    result = (visitor.document_type == type && visitor.document_number == number)

    VisitorValidationResult.new(result, visitor)
  end
end
