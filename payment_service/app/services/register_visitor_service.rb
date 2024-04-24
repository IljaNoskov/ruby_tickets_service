class RegisterVisitorService
  def self.call(visitor)
    client = HTTPClient.new
    response = client.post Settings.create_visitor_url, { visitor: visitor }
    result = JSON.parse(response.content)

    raise VisitorRegistrationException, result if response.status == 400

    Visitor.new(result)
  end
end
