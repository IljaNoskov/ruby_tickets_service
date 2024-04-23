require 'rails_helper'

RSpec.describe TicketBlockAdapter, :type => :request do
  it 'return successfully' do
    parametr = {
        'ticket_id' => 1,
        'block' => true,
        'document' => '23'
      }
    # подставляем данные, которые должен возвращать сторонний сервис
    stub_request(:put, ENV['PATH_TO_TICKET_BLOCK']).with(body: parametr)
    .to_return(status: 201, body: '', headers: {})
    # Получаем ответ метода
    response = TicketBlockAdapter.new(ENV['PATH_TO_TICKET_BLOCK']).call(1, true, '23')
    # сравниваем, что получили и что ожидали
    expect(response).to eq('successfully')
  end
  it 'return failed' do
    parametr = {
        'ticket_id' => 1,
        'block' => true,
        'document' => '23'
      }
    # подставляем данные, которые должен возвращать сторонний сервис
    stub_request(:put, ENV['PATH_TO_TICKET_BLOCK']).with(body: parametr)
    .to_return(status: 404, body: '', headers: {})
    # Получаем ответ метода
    response = TicketBlockAdapter.new(ENV['PATH_TO_TICKET_BLOCK']).call(1, true, '23')
    # сравниваем, что получили и что ожидали
    expect(response).to eq('failed')
  end
end