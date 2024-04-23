require 'rails_helper'

RSpec.describe TicketInfoAdapter, :type => :request do
  it 'return body' do
    parametr = {
        'ticket_id' => 1
      }
    res = {
      'id' => 1,
      'event_id' => 1,
      'type' => 'standart',
      'status' => 'buy',
      'user_id' => 3
    }
    # подставляем данные, которые должен возвращать сторонний сервис

    stub_request(:get, ENV['PATH_TO_TICKET_INFO']).with(query: parametr)
    .to_return(status: 200, body: res.to_json, headers: {})
    # Получаем ответ метода
    response = TicketInfoAdapter.new(ENV['PATH_TO_TICKET_INFO']).call(1)
    # сравниваем, что получили и что ожидали
    expect(response.body).to eq(res.to_json)
  end
  it 'return 404' do
    parametr = {
        'ticket_id' => 1
      }
    # подставляем данные, которые должен возвращать сторонний сервис
    stub_request(:get, ENV['PATH_TO_TICKET_INFO']).with(query: parametr)
    .to_return(status: 404, body: '', headers: {})
    # Получаем ответ метода
    response = TicketInfoAdapter.new(ENV['PATH_TO_TICKET_INFO']).call(1)
    # сравниваем, что получили и что ожидали
    expect(response.status).to eq(404)
  end
end