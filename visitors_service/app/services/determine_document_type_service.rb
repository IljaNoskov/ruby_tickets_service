class DetermineDocumentTypeService
  DOCUMENTS_FORMATS = {
    'passport' => /\A\d{10}\z/,
    'license' => /\A(\d{4})|(\d{2}[А-Я]{2})\d{4}\z/,
    'certificate' => /\A[IVX]+[А-Я]{2}\d{6}\z/
  }

  def self.call(document_number)
    return nil unless document_number

    DOCUMENTS_FORMATS.each do |type, format|
      return type if format.match?(document_number)
    end

    nil
  end
end
