class RegisterVisitorService
  def self.call(visitor)
    client = HTTPClient.new
    response = client.post Settings.create_visitor_url, { visitor: visitor }
    result = JSON.parse(response.content)

    raise VisitorRegistrationException, result unless response.ok?

    Visitor.new(result)

  rescue HTTPClient::TimeoutError => _
    raise ServiceUnavailableException, I18n.t(:visitors_service_unavailable)
  end
end
