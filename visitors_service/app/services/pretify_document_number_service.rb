class PretifyDocumentNumberService
  def self.call(document_number)
    document_number&.gsub(/[-\s]+/, '')
  end
end
