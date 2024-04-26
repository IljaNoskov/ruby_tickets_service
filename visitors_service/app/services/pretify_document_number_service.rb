# frozen_string_literal: true

# удаляет определенные символы из номера документа
class PretifyDocumentNumberService
  def self.call(document_number)
    document_number&.gsub(/[-\s]+/, '')
  end
end
