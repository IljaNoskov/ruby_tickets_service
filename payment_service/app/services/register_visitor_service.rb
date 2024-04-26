# frozen_string_literal: true

# Сервис регистрации посетителя
class RegisterVisitorService

  # метод вызова сервиса
  def self.call(visitor)
    client = HTTPClient.new

    body = { visitor: visitor.to_json }
    response = client.post(Settings.create_visitor_url, :body => body)
    result = JSON.parse(response.content)

    raise VisitorRegistrationException, result unless response.ok?

    Visitor.new(result)
  rescue HTTPClient::TimeoutError => _e
    raise ServiceUnavailableException, I18n.t(:visitors_service_unavailable)
  end
end
