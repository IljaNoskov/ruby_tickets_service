class DocumentNumberValidator < ActiveModel::Validator
  DOCUMENTS_FORMATS = {
    passport: /\A\d{10}\z/,
    license: /\A(\d{4})|(\d{2}[А-Я]{2})\d{4}\z/,
    certificate: /\A[IVX]+[А-Я]{2}\d{6}\z/
  }

  def validate(record)
    format = DOCUMENTS_FORMATS[record.document_type.to_sym]
    return if format && format.match?(record.document_number)

    record.errors.add :document_number, I18n.t(:uncorrect_format)
  end
end
