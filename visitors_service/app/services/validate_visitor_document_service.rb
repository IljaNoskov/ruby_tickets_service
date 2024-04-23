class ValidateVisitorDocumentService
  def self.call(id, document_type, document_number)
    number = PretifyDocumentNumberService.call(document_number)
    type = document_type || DetermineDocumentTypeService.call(number)

    visitor = Visitor.find(id)
    result = (visitor.document_type == document_type && visitor.document_number == document_number)

    VisitorValidationResult.new(result, visitor)
  end
end
