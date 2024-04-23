class TicketBlockAdapter
  def initialize(url = nil)
    @url = url
    @client = HTTPClient.new
  end

  def call(ticket_id, block, document)
    parametr = {
        'ticket_id' => ticket_id,
        'block' => block,
        'document' => document
      }
    response = @client.put(@url,parametr).status
    # если вернул true, значит успешно заблокировали
    # если false, то заблокировать не получилось
    response == 201 ? "successfully" : "failed"
  end
end