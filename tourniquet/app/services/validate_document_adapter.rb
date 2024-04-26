class ValidateDocumentAdapter
  def initialize(url = nil)
    @url = url
    @client = HTTPClient.new
  end

  def validate_document(visitor_id, document)
    parametr = {
        'id' => visitor_id,
        'document_number' => document
      }
    response = @client.get(@url,parametr)

    # response = {
    #   'status' => 200,
    #   'body' => {
    #         'result' => true,
    #         'visitor' => {
    #           'first_name' => 'D',
    #           'middle_name' => 'I',
    #           'last_name' => 'SH'
    #         }
    #     }
    #   }
  end
end
