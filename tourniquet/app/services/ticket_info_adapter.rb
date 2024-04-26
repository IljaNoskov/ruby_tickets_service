class TicketInfoAdapter
  def initialize(url = nil)
    @url = url
    @client = HTTPClient.new
  end
  
  def call(ticket_id)
    parametr = {
        'ticket_id' => ticket_id
      }
    response = @client.get(@url,parametr)

    # response2 = {"status" => 200, "body" => {
    #   'id' => 1,
    #   'event_id' => 1,
    #   'type' => 'standart',
    #   'status' => 'buy',
    #   'user_id' => 3
    # }}
  end
end